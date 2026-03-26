import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme_provider.dart';

final accountProvider = Provider<AccountController>((ref) {
  return AccountController(ref);
});

class AccountController {
  AccountController(this._ref);
  final Ref _ref;

  Future<void> setTheme(ThemeMode mode) async {
    _ref.read(themeProvider.notifier).state = mode;
    await persistThemePreference(mode);
  }
}
