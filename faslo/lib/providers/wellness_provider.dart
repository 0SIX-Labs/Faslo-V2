import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '../core/constants/pref_keys.dart';
import '../core/utils/debounce.dart';
import '../models/water_entry.dart';
import '../models/weight_entry.dart';
import '../models/mood_entry.dart';

class WellnessProvider extends ChangeNotifier {
  List<WaterEntry> _water = [];
  List<WeightEntry> _weight = [];
  List<MoodEntry> _mood = [];

  // Debouncer for water updates (400ms delay)
  final _waterDebouncer = Debouncer(delay: const Duration(milliseconds: 400));

  List<WaterEntry> get water => List.unmodifiable(_water);
  List<WeightEntry> get weight => List.unmodifiable(_weight);
  List<MoodEntry> get mood => List.unmodifiable(_mood);

  String _todayStr() {
    final d = DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  int get todayGlasses => getTodayWater();

  /// Calculate consecutive water streak days
  int get waterStreak {
    int streak = 0;
    final now = DateTime.now();

    for (int i = 0; true; i++) {
      final checkDate = now.subtract(Duration(days: i));
      final dayStr =
          '${checkDate.year}-${checkDate.month.toString().padLeft(2, '0')}-${checkDate.day.toString().padLeft(2, '0')}';

      final idx = _water.indexWhere((e) => e.date == dayStr);
      final glasses = idx >= 0 ? _water[idx].glasses : 0;

      if (glasses >= 6) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  // Get today's water count (O(1) operation)
  int getTodayWater() {
    final today = _todayStr();
    // First check in-memory list for instant UI updates
    final idx = _water.indexWhere((e) => e.date == today);
    if (idx >= 0) {
      return _water[idx].glasses;
    }
    // Fallback to Hive only if not in memory
    final box = Hive.box<int>('water_entries');
    return box.get(today) ?? 0;
  }

  // Increment today's water count (O(1) operation) with debouncing
  Future<void> incrementWater() async {
    final today = _todayStr();
    final box = Hive.box<int>('water_entries');

    // Always use in-memory value first for immediate updates
    final idx = _water.indexWhere((e) => e.date == today);
    final current = idx >= 0 ? _water[idx].glasses : box.get(today) ?? 0;
    // Limit maximum to 8 glasses
    if (current >= 8) return;
    final newValue = current + 1;

    // Update in-memory list immediately for responsive UI
    if (idx >= 0) {
      _water[idx] = WaterEntry(date: today, glasses: newValue);
    } else {
      _water.add(WaterEntry(date: today, glasses: newValue));
    }
    notifyListeners();

    // Debounce the disk write
    await _waterDebouncer.run(() async {
      await box.put(today, newValue);
    });
  }

  // Decrement today's water count (O(1) operation) with debouncing
  Future<void> decrementWater() async {
    final today = _todayStr();
    final box = Hive.box<int>('water_entries');

    // Always use in-memory value first for immediate updates
    final idx = _water.indexWhere((e) => e.date == today);
    final current = idx >= 0 ? _water[idx].glasses : box.get(today) ?? 0;
    if (current <= 0) return;

    final newValue = current - 1;

    // Update in-memory list immediately for responsive UI
    if (idx >= 0) {
      _water[idx] = WaterEntry(date: today, glasses: newValue);
    }
    notifyListeners();

    // Debounce the disk write
    await _waterDebouncer.run(() async {
      await box.put(today, newValue);
    });
  }

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load water entries from Hive (optimized: store only glasses count)
      final waterBox = Hive.box<int>('water_entries');
      if (waterBox.isEmpty) {
        // Migration: Check for existing JSON data in SharedPreferences
        final raw = prefs.getString(PrefKeys.waterEntries);
        if (raw != null && raw.isNotEmpty && raw != '[]') {
          try {
            final list = jsonDecode(raw) as List;
            final entries = list
                .map((e) => WaterEntry.fromJson(e as Map<String, dynamic>))
                .toList();
            // Save to Hive as simple int values (date -> glasses count)
            for (final entry in entries) {
              await waterBox.put(entry.date, entry.glasses);
            }
            // Clear old JSON data
            await prefs.remove(PrefKeys.waterEntries);
          } catch (_) {
            // Migration failed
          }
        }
      }

      // Load water entries from Hive into memory for compatibility
      _water = waterBox.keys.map((date) {
        final glasses = waterBox.get(date) ?? 0;
        return WaterEntry(date: date as String, glasses: glasses);
      }).toList();

      // Load weight and mood entries from SharedPreferences (not migrated)
      _weight = _decode<WeightEntry>(
          prefs.getString(PrefKeys.weightEntries), WeightEntry.fromJson);
      _mood = _decode<MoodEntry>(
          prefs.getString(PrefKeys.moodEntries), MoodEntry.fromJson);
      notifyListeners();
    } catch (e) {
      // Use defaults on error
    }
  }

  List<T> _decode<T>(String? raw, T Function(Map<String, dynamic>) fn) {
    if (raw == null || raw.isEmpty) return [];
    try {
      return (jsonDecode(raw) as List)
          .map((e) => fn(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> addGlass() async {
    await incrementWater();
  }

  Future<void> logWeight(double kg) async {
    final today = _todayStr();
    _weight.removeWhere((e) => e.date == today);
    _weight.insert(0, WeightEntry(date: today, valueKg: kg));
    await _save(
        PrefKeys.weightEntries, _weight.map((e) => e.toJson()).toList());
    notifyListeners();
  }

  Future<void> logMood(int score) async {
    final today = _todayStr();
    _mood.removeWhere((e) => e.date == today);
    _mood.insert(0, MoodEntry(date: today, score: score));
    await _save(PrefKeys.moodEntries, _mood.map((e) => e.toJson()).toList());
    notifyListeners();
  }

  Future<void> _save(String key, List<dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, jsonEncode(data));
    } catch (e) {
      // Continue even if save fails
    }
  }

  /// Flushes any pending debounced water saves to disk.
  /// Call this when the app is about to close or when immediate persistence is needed.
  Future<void> flushWaterSave() async {
    await _waterDebouncer.flush();
  }

  @override
  void dispose() {
    _waterDebouncer.dispose();
    super.dispose();
  }
}
