import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../core/constants/pref_keys.dart';
import '../core/constants/fasting_plans.dart';
import '../models/fast_session.dart';

class FastProvider extends ChangeNotifier {
  FastingPlan _activePlan = fastingPlans[2]; // 16:8 default
  DateTime? _fastStart;
  Duration _elapsed = Duration.zero;
  Timer? _ticker;
  List<FastSession> _sessions = [];

  FastingPlan get activePlan => _activePlan;
  DateTime? get fastStart => _fastStart;
  Duration get elapsed => _elapsed;
  bool get isFasting => _fastStart != null;
  List<FastSession> get sessions => List.unmodifiable(_sessions);

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
      // Load sessions
      final raw = prefs.getString(PrefKeys.fastSessions) ?? '[]';
      final list = jsonDecode(raw) as List;
      _sessions = list
          .map((e) => FastSession.fromJson(e as Map<String, dynamic>))
          .toList();
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
        notifyListeners();
      }
    });
  }

  Future<void> startFast() async {
    _fastStart = DateTime.now();
    _startTicker();
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
    final session = FastSession(
      id: const Uuid().v4(),
      startTime: _fastStart!,
      endTime: DateTime.now(),
      planRatio: _activePlan.ratio,
      targetHours: _activePlan.fastHours,
      completed: true,
    );
    _sessions.insert(0, session);
    _fastStart = null;
    _elapsed = Duration.zero;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(PrefKeys.activeFastStart);
      await _saveSessions(prefs);
    } catch (e) {
      // Continue even if save fails
    }
    notifyListeners();
    return session;
  }

  Future<void> setActivePlan(FastingPlan plan) async {
    _activePlan = plan;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PrefKeys.activePlan, plan.ratio);
    } catch (e) {
      // Continue even if save fails
    }
    notifyListeners();
  }

  Future<void> _saveSessions(SharedPreferences prefs) async {
    await prefs.setString(
      PrefKeys.fastSessions,
      jsonEncode(_sessions.map((s) => s.toJson()).toList()),
    );
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
