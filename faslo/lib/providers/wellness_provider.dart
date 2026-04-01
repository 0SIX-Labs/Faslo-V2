import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/pref_keys.dart';
import '../models/water_entry.dart';
import '../models/weight_entry.dart';
import '../models/mood_entry.dart';

class WellnessProvider extends ChangeNotifier {
  List<WaterEntry> _water = [];
  List<WeightEntry> _weight = [];
  List<MoodEntry> _mood = [];

  List<WaterEntry> get water => List.unmodifiable(_water);
  List<WeightEntry> get weight => List.unmodifiable(_weight);
  List<MoodEntry> get mood => List.unmodifiable(_mood);

  String _todayStr() {
    final d = DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  int get todayGlasses {
    final today = _todayStr();
    final entry = _water.where((e) => e.date == today).toList();
    return entry.isEmpty ? 0 : entry.first.glasses;
  }

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _water = _decode<WaterEntry>(
          prefs.getString(PrefKeys.waterEntries), WaterEntry.fromJson);
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
    final today = _todayStr();
    final idx = _water.indexWhere((e) => e.date == today);
    if (idx >= 0) {
      _water[idx] = WaterEntry(date: today, glasses: _water[idx].glasses + 1);
    } else {
      _water.add(WaterEntry(date: today, glasses: 1));
    }
    await _save(PrefKeys.waterEntries, _water.map((e) => e.toJson()).toList());
    notifyListeners();
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
}
