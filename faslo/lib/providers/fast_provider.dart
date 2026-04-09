import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import '../core/constants/pref_keys.dart';
import '../core/constants/fasting_plans.dart';
import '../core/utils/debounce.dart';
import '../models/fast_session.dart';
import '../services/notification_service.dart';

class FastProvider extends ChangeNotifier {
  FastingPlan _activePlan = fastingPlans[2]; // 16:8 default
  DateTime? _fastStart;
  Duration _elapsed = Duration.zero;
  Timer? _ticker;
  List<FastSession> _sessions = [];

  // Debouncer for session saves (400ms delay)
  final _sessionDebouncer = Debouncer(delay: const Duration(milliseconds: 400));

  FastingPlan get activePlan => _activePlan;
  DateTime? get fastStart => _fastStart;
  Duration get elapsed => _elapsed;
  bool get isFasting => _fastStart != null;
  List<FastSession> get sessions => List.unmodifiable(_sessions);

  // Get recent sessions with limit (avoids loading entire dataset)
  List<FastSession> getRecentSessions(int limit) {
    final box = Hive.box<FastSession>('fast_sessions');
    final allSessions = box.values.toList();
    allSessions.sort((a, b) => b.startTime.compareTo(a.startTime));
    return allSessions.take(limit).toList();
  }

  // Get sessions by specific date
  List<FastSession> getSessionsByDate(DateTime date) {
    final dateStr = _dayStr(date);
    final box = Hive.box<FastSession>('fast_sessions');
    return box.values
        .where((session) => _dayStr(session.startTime) == dateStr)
        .toList()
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
  }

  // Streak = consecutive days with at least 1 completed fast
  int get streak {
    if (_sessions.isEmpty) return 0;
    int count = 0;
    DateTime day = DateTime.now();
    for (int i = 0; i < 365; i++) {
      final dayStr = _dayStr(day.subtract(Duration(days: i)));
      final hasCompleted = _sessions.any(
        (s) => s.completed && _dayStr(s.startTime) == dayStr,
      );
      if (hasCompleted) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  String _dayStr(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Load active plan
      final planRatio = prefs.getString(PrefKeys.activePlan) ?? '16:8';
      _activePlan = fastingPlans.firstWhere(
        (p) => p.ratio == planRatio,
        orElse: () => fastingPlans[2],
      );
      // Restore active fast if app was killed mid-fast
      final startStr = prefs.getString(PrefKeys.activeFastStart) ?? '';
      if (startStr.isNotEmpty) {
        _fastStart = DateTime.tryParse(startStr);
        if (_fastStart != null) _startTicker();
      }

      // Load sessions from Hive
      final box = Hive.box<FastSession>('fast_sessions');
      if (box.isEmpty) {
        // Migration: Check for existing JSON data in SharedPreferences
        final raw = prefs.getString(PrefKeys.fastSessions);
        if (raw != null && raw.isNotEmpty && raw != '[]') {
          try {
            final list = jsonDecode(raw) as List;
            final sessions = list
                .map((e) => FastSession.fromJson(e as Map<String, dynamic>))
                .toList();
            // Save to Hive with timestamp-based key for ordering
            for (int i = 0; i < sessions.length; i++) {
              final session = sessions[i];
              // Use timestamp as key prefix to maintain order
              final key =
                  '${session.startTime.millisecondsSinceEpoch}_${session.id}';
              await box.put(key, session);
            }
            // Clear old JSON data
            await prefs.remove(PrefKeys.fastSessions);
          } catch (_) {
            // Migration failed, start fresh
          }
        }
      }

      // Load only recent sessions into memory (limit to 100 for performance)
      _sessions = getRecentSessions(100);

      notifyListeners();
    } catch (e) {
      // Use defaults on error
    }
  }

  void _startTicker() {
    _ticker?.cancel();
    _elapsed = _fastStart != null
        ? DateTime.now().difference(_fastStart!)
        : Duration.zero;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_fastStart != null) {
        _elapsed = DateTime.now().difference(_fastStart!);

        // Update ongoing notification every minute
        if (_elapsed.inSeconds % 60 == 0) {
          final endTime =
              _fastStart!.add(Duration(hours: _activePlan.fastHours));
          NotificationService.updateOngoingNotification(endTime);
        }

        notifyListeners();
      }
    });
  }

  Future<void> startFast() async {
    _fastStart = DateTime.now();
    _startTicker();

    final endTime = _fastStart!.add(Duration(hours: _activePlan.fastHours));

    // Show start notification
    await NotificationService.showFastStarted(endTime);

    // Schedule milestone notifications
    await NotificationService.scheduleHalfway(
        _fastStart!, _activePlan.fastHours);
    await NotificationService.scheduleKetosis(_fastStart!);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          PrefKeys.activeFastStart, _fastStart!.toIso8601String());
    } catch (e) {
      // Continue with fast even if save fails
    }
    notifyListeners();
  }

  Future<FastSession?> stopFast() async {
    if (_fastStart == null) return null;
    _ticker?.cancel();

    final duration = DateTime.now().difference(_fastStart!);
    final hours = duration.inHours;

    final session = FastSession(
      id: const Uuid().v4(),
      startTime: _fastStart!,
      endTime: DateTime.now(),
      planRatio: _activePlan.ratio,
      targetHours: _activePlan.fastHours,
      completed: true,
    );
    _fastStart = null;
    _elapsed = Duration.zero;

    // Cancel all scheduled notifications and ongoing notification
    await NotificationService.cancelOngoing();
    await NotificationService.cancelAll();

    // Show completion notification if fast was at least 1 hour
    if (hours >= 1) {
      await NotificationService.showFastComplete(hours);
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(PrefKeys.activeFastStart);
      // Save to Hive with timestamp-based key for ordering
      final box = Hive.box<FastSession>('fast_sessions');
      final key = '${session.startTime.millisecondsSinceEpoch}_${session.id}';
      await box.put(key, session);
      // Reload recent sessions
      _sessions = getRecentSessions(100);
    } catch (e) {
      // Continue even if save fails
    }
    notifyListeners();
    return session;
  }

  Future<void> setActivePlan(FastingPlan plan) async {
    // Prevent changing plan while fasting is active
    if (isFasting) return;

    _activePlan = plan;
    notifyListeners();

    // Debounce the disk write
    await _sessionDebouncer.run(() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(PrefKeys.activePlan, plan.ratio);
      } catch (e) {
        // Continue even if save fails
      }
    });
  }

  // Removed _saveSessions method - now using Hive directly

  /// Flushes any pending debounced saves to disk.
  /// Call this when the app is about to close or when immediate persistence is needed.
  Future<void> flushPendingSaves() async {
    await _sessionDebouncer.flush();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _sessionDebouncer.dispose();
    super.dispose();
  }
}
