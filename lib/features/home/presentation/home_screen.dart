import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/snackbar_service.dart';
import '../../account/providers/account_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../history/providers/history_provider.dart';
import '../../profile/data/providers/profile_provider.dart';
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
      body: RefreshIndicator(
        color: AppColors.primaryEmerald,
        onRefresh: () async {
          await Future.wait([
            ref.read(historyProvider.notifier).refresh(),
            ref.refresh(userProfileProvider.future),
            ref.refresh(historyStatsProvider.future),
            ref.read(authNotifierProvider.notifier).refreshUser(),
          ]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                                'QUICK SCAN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
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
                      'Instant Food &\nIngredient Health Check',
                      style: AppTextStyles.heading2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Scan any product packaging to uncover hidden additives, health risks & allergens.',
                      style: AppTextStyles.body2.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/scan/barcode'),
                        icon: const Icon(Icons.qr_code_scanner_rounded, color: Color(0xFF065F46), size: 20),
                        label: const Text(
                          'Scan Barcode Now',
                          style: TextStyle(
                            color: Color(0xFF065F46),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF065F46),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Onboarding Reminder Card if Profile is incomplete
              if (needsOnboarding) ...[
                const ProfileOnboardingCard(),
                const SizedBox(height: 20),
              ],

              // Analysis Options Grid
              Text(
                'More Analysis Options',
                style: AppTextStyles.heading3.copyWith(
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 16),

              // Paste Ingredients Quick Tile
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryEmerald.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.edit_note_rounded,
                      color: AppColors.primaryEmerald,
                      size: 22,
                    ),
                  ),
                  onTap: () => context.push('/scan/manual'),
                  title: Text(
                    'Manual Ingredient Entry',
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
