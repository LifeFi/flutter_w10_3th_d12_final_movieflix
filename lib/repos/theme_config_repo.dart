import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeConfigRepository {
  final SharedPreferences _preferences;

  ThemeConfigRepository(this._preferences);

  // enum ThemeMode { system, light, dark }
  ThemeMode getThemeMode() {
    final themeModeIndex = _preferences.getInt('themeMode') ?? 0;
    return ThemeMode.values[themeModeIndex];
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _preferences.setInt('themeMode', themeMode.index);
  }
}
