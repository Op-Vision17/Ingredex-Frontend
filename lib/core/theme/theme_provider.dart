import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'theme_mode';

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

Future<void> loadThemePreference(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final raw = prefs.getString(_themeKey);
  final mode = switch (raw) {
    'dark' => ThemeMode.dark,
    'system' => ThemeMode.system,
    _ => ThemeMode.light,
  };
  ref.read(themeProvider.notifier).state = mode;
}

Future<void> persistThemePreference(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  final value = switch (mode) {
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
    ThemeMode.light => 'light',
  };
  await prefs.setString(_themeKey, value);
}
