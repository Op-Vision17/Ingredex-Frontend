import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/utils/snackbar_service.dart';

class IngredexApp extends ConsumerStatefulWidget {
  const IngredexApp({super.key});

  @override
  ConsumerState<IngredexApp> createState() => _IngredexAppState();
}

class _IngredexAppState extends ConsumerState<IngredexApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await loadThemePreference(ref);
      // Session is validated in [AuthNotifier.build]; avoid a second /auth/me here.
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Ingredex',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: SnackBarService.messengerKey,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
