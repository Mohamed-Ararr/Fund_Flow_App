import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeController {
  static const _themeKey = 'app_theme_mode';

  /// Global notifier listened by MaterialApp
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(ThemeMode.system);

  /// Call on app start
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_themeKey);

    themeMode.value = _stringToThemeMode(stored);
  }

  /// Toggle light <-> dark
  static Future<void> toggle(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();

    final mode = isDark ? ThemeMode.dark : ThemeMode.light;
    themeMode.value = mode;

    await prefs.setString(_themeKey, mode.name);
  }

  /// Used by Settings switch
  static bool isDarkMode() {
    return themeMode.value == ThemeMode.dark;
  }

  static ThemeMode _stringToThemeMode(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
