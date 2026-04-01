import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/pref_keys.dart';

class SettingsProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  bool _isMetric = true;
  bool _is24h = true;
  String _userName = '';
  int _waterGoal = 8;

  // Notifications
  bool _notifFastEnd = true;
  bool _notifHalfway = true;
  bool _notifKetosis = true;
  bool _notifWater = true;

  Locale get locale => _locale;
  bool get isMetric => _isMetric;
  bool get is24h => _is24h;
  String get userName => _userName;
  int get waterGoal => _waterGoal;
  bool get notifFastEnd => _notifFastEnd;
  bool get notifHalfway => _notifHalfway;
  bool get notifKetosis => _notifKetosis;
  bool get notifWater => _notifWater;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _locale = Locale(prefs.getString(PrefKeys.appLocale) ?? 'en');
      _isMetric = prefs.getString(PrefKeys.units) != 'imperial';
      _is24h = prefs.getString(PrefKeys.clockFormat) != '12h';
      _userName = prefs.getString(PrefKeys.userName) ?? '';
      _waterGoal = prefs.getInt(PrefKeys.waterGoal) ?? 8;
      _notifFastEnd = prefs.getBool(PrefKeys.notifFastEnd) ?? true;
      _notifHalfway = prefs.getBool(PrefKeys.notifHalfway) ?? true;
      _notifKetosis = prefs.getBool(PrefKeys.notifKetosis) ?? true;
      _notifWater = prefs.getBool(PrefKeys.notifWater) ?? true;
      notifyListeners();
    } catch (e) {
      // Use defaults on error
    }
  }

  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PrefKeys.appLocale, languageCode);
    } catch (e) {
      // Continue even if save fails
    }
    notifyListeners();
  }

  Future<void> setMetric(bool v) async {
    _isMetric = v;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PrefKeys.units, v ? 'metric' : 'imperial');
    } catch (e) {
      // Continue even if save fails
    }
    notifyListeners();
  }

  Future<void> set24h(bool v) async {
    _is24h = v;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PrefKeys.clockFormat, v ? '24h' : '12h');
    } catch (e) {
      // Continue even if save fails
    }
    notifyListeners();
  }

  Future<void> setUserName(String v) async {
    _userName = v;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PrefKeys.userName, v);
    } catch (e) {
      // Continue even if save fails
    }
    notifyListeners();
  }

  Future<void> setNotif(String key, bool v) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, v);
    } catch (e) {
      // Continue even if save fails
    }
    if (key == PrefKeys.notifFastEnd) _notifFastEnd = v;
    if (key == PrefKeys.notifHalfway) _notifHalfway = v;
    if (key == PrefKeys.notifKetosis) _notifKetosis = v;
    if (key == PrefKeys.notifWater) _notifWater = v;
    notifyListeners();
  }

  Future<void> resetAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await init();
    } catch (e) {
      // Use defaults on error
    }
  }
}
