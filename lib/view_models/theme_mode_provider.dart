import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/repos/theme_config_repo.dart';

final themeConfigProvider = NotifierProvider<ThemeConfigViewModel, ThemeMode>(
  () => throw UnimplementedError(),
);

class ThemeConfigViewModel extends Notifier<ThemeMode> {
  final ThemeConfigRepository _themeConfigRepository;

  ThemeConfigViewModel(this._themeConfigRepository);

  void toggleTheme() {
    if (state == ThemeMode.system) {
      state = ThemeMode.light;
    } else if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
    _themeConfigRepository.setThemeMode(state);
  }

  void getThemeMode() async {
    state = _themeConfigRepository.getThemeMode();
  }

  @override
  ThemeMode build() {
    return _themeConfigRepository.getThemeMode();
  }
}
