import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/snackbar_service.dart';
import '../../account/providers/account_provider.dart';
import '../../auth/providers/auth_provider.dart';
import 'widgets/profile_onboarding_card.dart';
import 'widgets/recent_scans_section.dart';
import 'widgets/scan_options_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _firstNameFromEmail(String? email) {
    if (email == null || email.trim().isEmpty) return 'there';
    final local = email.split('@').first;
    final part = local.split(RegExp(r'[._-]')).first;
    if (part.isEmpty) return 'there';
    return '${part[0].toUpperCase()}${part.substring(1)}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mode = ref.watch(themeProvider);
    final authState = ref.watch(authNotifierProvider).valueOrNull;
    final email = authState?.maybeWhen(
      authenticated: (user, _) => user.email,
      orElse: () => null,
    );
    final firstName = _firstNameFromEmail(email);
    final needsOnboarding = authState?.maybeWhen(
          authenticated: (user, _) => user.needsOnboarding,
          orElse: () => false,
        ) ??
        false;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Image.asset(
                'assets/app_logo_bgremove.png',
                width: 26,
                height: 26,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, $firstName! 👋',
                  style: AppTextStyles.heading3.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Know what you eat',
                  style: AppTextStyles.caption.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () async {
              final next = mode == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              await ref.read(accountProvider).setTheme(next);
            },
            icon: Icon(
              mode == ThemeMode.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
          ),
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {
              SnackBarService.show('You are all caught up! No new notifications.');
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          PopupMenuButton<String>(
            tooltip: 'Account Menu',
            icon: const Icon(Icons.account_circle_outlined),
            onSelected: (value) async {
              if (value == 'profile') {
                context.push('/account/profile');
              } else if (value == 'account') {
                context.go('/account');
              } else if (value == 'logout') {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Log Out?'),
                    content: const Text('Are you sure you want to log out of Ingredex?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.highRisk,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Log Out'),
                      ),
                    ],
                  ),
                );
                if (ok == true) {
                  await ref.read(authNotifierProvider.notifier).logout();
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'account',
                child: Row(
                  children: [
                    Icon(Icons.manage_accounts_outlined, size: 20),
                    SizedBox(width: 10),
                    Text('My Account'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.health_and_safety_outlined, size: 20),
                    SizedBox(width: 10),
                    Text('Health Profile'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded, color: AppColors.highRisk, size: 20),
                    SizedBox(width: 10),
                    Text('Log Out', style: TextStyle(color: AppColors.highRisk)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Action Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF059669), // Emerald Dark
                    Color(0xFF10B981), // Emerald Primary
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt_rounded, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'AI-POWERED ANALYSIS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Instant Food & Ingredient Health Check',
                    style: AppTextStyles.heading2.copyWith(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Detect hidden toxins, harmful preservatives & allergens in seconds.',
                    style: AppTextStyles.body2.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => context.push('/scan/barcode'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF047857),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.qr_code_scanner_rounded, size: 20),
                      label: Text(
                        'Quick Scan Barcode',
                        style: AppTextStyles.button.copyWith(
                          color: const Color(0xFF047857),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (needsOnboarding) ...[
              const SizedBox(height: 18),
              const ProfileOnboardingCard(),
            ],

            const SizedBox(height: 22),
            Text(
              'More Analysis Options',
              style: AppTextStyles.heading3.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 12),

            // Scan Options Grid: Barcode 1st, Ingredients OCR 2nd
            Row(
              children: [
                Expanded(
                  child: ScanOptionsCard(
                    title: 'Scan Barcode',
                    subtitle: 'Instant product lookup',
                    icon: Icons.qr_code_scanner_rounded,
                    accentColor: AppColors.accentTangerine,
                    onTap: () => context.push('/scan/barcode'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ScanOptionsCard(
                    title: 'Scan Label',
                    subtitle: 'Camera OCR text',
                    icon: Icons.camera_alt_rounded,
                    accentColor: AppColors.primaryEmerald,
                    onTap: () => context.push('/scan/ocr'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Manual Entry Full Card
            Material(
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 1,
                ),
              ),
              child: ListTile(
                onTap: () => context.push('/scan/manual'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.accentAmber.withValues(alpha: isDark ? 0.20 : 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.accentAmber.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.edit_note_rounded,
                    color: AppColors.accentAmber,
                    size: 22,
                  ),
                ),
                title: Text(
                  'Type ingredients manually',
                  style: AppTextStyles.heading3.copyWith(
                    fontSize: 15,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                subtitle: Text(
                  'Paste from online product page or write text',
                  style: AppTextStyles.caption.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ),

            const SizedBox(height: 24),
            // Recent Scans Section with Live History
            const RecentScansSection(),
          ],
        ),
      ),
    );
  }
}
