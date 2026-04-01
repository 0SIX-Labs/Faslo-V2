import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/pref_keys.dart';
import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _mode = AppThemeMode.sageMint; // DEFAULT
  bool _isMinimalOled = false;

  AppThemeMode get mode => _mode;
  bool get isMinimalOled => _isMinimalOled;
  bool get isDark => _mode == AppThemeMode.kineticObsidian || _isMinimalOled;

  ThemeData get themeData {
    if (_isMinimalOled) return AppTheme.minimalOled();
    switch (_mode) {
      case AppThemeMode.sageMint:
        return AppTheme.sageMint();
      case AppThemeMode.kineticObsidian:
        return AppTheme.kineticObsidian();
      case AppThemeMode.zenPaper:
        return AppTheme.zenPaper();
      case AppThemeMode.minimalOled:
        return AppTheme.minimalOled();
    }
  }

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(PrefKeys.appTheme);
      if (saved != null) {
        _mode = AppThemeMode.values.firstWhere(
          (e) => e.name == saved,
          orElse: () => AppThemeMode.sageMint,
        );
      }
      notifyListeners();
    } catch (e) {
      // Use default theme on error
    }
  }

  Future<void> setTheme(AppThemeMode mode) async {
    _mode = mode;
    _isMinimalOled = false;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PrefKeys.appTheme, mode.name);
    } catch (e) {
      // Continue with theme change even if save fails
    }
    notifyListeners();
  }

  void toggleMinimalOled() {
    _isMinimalOled = !_isMinimalOled;
    notifyListeners();
  }
}
