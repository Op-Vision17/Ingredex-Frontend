import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/account/presentation/account_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/history/presentation/scan_detail_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/scan/presentation/analysis_result_screen.dart';
import '../../features/scan/presentation/barcode_scan_screen.dart';
import '../../features/scan/presentation/manual_entry_screen.dart';
import '../../features/scan/presentation/ocr_scan_screen.dart';
import '../constants/app_colors.dart';

class _RouterRefreshNotifier extends ChangeNotifier {
  void refresh() => notifyListeners();
}

final routerRefreshNotifierProvider = Provider<_RouterRefreshNotifier>((ref) {
  final notifier = _RouterRefreshNotifier();
  ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (_, _) {
    notifier.refresh();
  });
  ref.onDispose(notifier.dispose);
  return notifier;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(routerRefreshNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final auth = ref.read(authNotifierProvider);
      final authState = auth.valueOrNull;
      final path = state.matchedLocation;

      final isBootstrap =
          authState == null ||
          authState.maybeWhen(unknown: () => true, orElse: () => false);
      if (isBootstrap) {
        return path == '/splash' ? null : '/splash';
      }

      final isAuthenticated = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );
      final isAuthPage = path == '/login' || path.startsWith('/otp/');

      if (path == '/splash') {
        if (isAuthenticated) return '/home';
        return '/login';
      }

      if (!isAuthenticated && !isAuthPage) return '/login';
      if (isAuthenticated && isAuthPage) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) =>
            Scaffold(body: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/app_logo_bgremove.png', width: 200, height: 200),
                const SizedBox(height: 24),
                const CircularProgressIndicator(),
              ],
            ))),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/otp/:email',
        builder: (context, state) => OtpScreen(
          email: Uri.decodeComponent(state.pathParameters['email'] ?? ''),
        ),
      ),
      GoRoute(path: '/', redirect: (_, state) => '/home'),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _BottomNavShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => ScanDetailScreen(
                      scanId: state.pathParameters['id'] ?? '',
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/account',
                builder: (context, state) => const AccountScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/scan/barcode',
        builder: (context, state) => const BarcodeScanScreen(),
      ),
      GoRoute(
        path: '/scan/ocr',
        builder: (context, state) => const OcrScanScreen(),
      ),
      GoRoute(
        path: '/scan/manual',
        builder: (context, state) => const ManualEntryScreen(),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) => AnalysisResultScreen(result: state.extra),
      ),
    ],
  );
});

class _BottomNavShell extends StatelessWidget {
  const _BottomNavShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactive = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 70,
            child: Row(
              children: [
                _NavItem(
                  label: 'Home',
                  icon: Icons.home_rounded,
                  isActive: navigationShell.currentIndex == 0,
                  inactiveColor: inactive,
                  onTap: () => _goBranch(0),
                ),
                _NavItem(
                  label: 'History',
                  icon: Icons.history_rounded,
                  isActive: navigationShell.currentIndex == 1,
                  inactiveColor: inactive,
                  onTap: () => _goBranch(1),
                ),
                _NavItem(
                  label: 'Account',
                  icon: Icons.person_rounded,
                  isActive: navigationShell.currentIndex == 2,
                  inactiveColor: inactive,
                  onTap: () => _goBranch(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.inactiveColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primaryOrange;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              width: 48,
              height: 28,
              decoration: BoxDecoration(
                color: isActive
                    ? activeColor.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                color: isActive ? activeColor : inactiveColor,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
