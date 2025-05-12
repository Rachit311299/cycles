import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  // Initialize with system or light/dark as you prefer.
  @override
  ThemeMode build() {
    return ThemeMode.light;
  }

  void toggleTheme(bool isDarkMode) {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

// The global provider for the theme mode.
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
