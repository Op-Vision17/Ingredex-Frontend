import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../auth/providers/auth_provider.dart';
import '../../history/providers/history_provider.dart';
import '../../../core/theme/theme_provider.dart';
import '../providers/account_provider.dart';

void _showAboutIngredex(BuildContext context) {
  showAboutDialog(
    context: context,
    applicationName: 'Ingredex',
    applicationVersion: '1.0.0',
    applicationIcon: const Icon(Icons.eco_rounded, color: AppColors.primaryOrange, size: 48),
    children: const [
      Text(
        'Ingredex helps you understand food ingredients. Scan barcodes, photograph labels, or enter ingredients manually to get health insights.',
      ),
    ],
  );
}

void _showPrivacyPolicy(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Privacy'),
      content: SingleChildScrollView(
        child: Text(
          'We use your email for sign-in and store scans you create in the app. '
          'Analysis requests may be sent to our servers. '
          'Do not enter information you consider highly sensitive. '
          'For a full policy or data deletion requests, contact the app operator.',
          style: Theme.of(ctx).textTheme.bodyMedium,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeProvider);
    final authState = ref.watch(authNotifierProvider).valueOrNull;
    final statsState = ref.watch(historyStatsProvider);
    final historyState = ref.watch(historyProvider);

    final user = authState?.maybeWhen(
      authenticated: (user, _) => user,
      orElse: () => null,
    );
    final email = user?.email ?? 'user@example.com';
    final initial = email.isNotEmpty ? email.characters.first.toUpperCase() : 'U';
    final memberSince = user == null
        ? '-'
        : DateFormat('dd MMM yyyy').format(DateTime.tryParse(user.createdAt)?.toLocal() ?? DateTime.now());

    final totalScans = statsState.valueOrNull?.totalScans ?? 0;
    final avgScore = historyState.valueOrNull == null || historyState.valueOrNull!.isEmpty
        ? 0.0
        : historyState.valueOrNull!
                .map((e) => (e.analysisResult?['health_score'] as num?)?.toDouble() ?? 0)
                .reduce((a, b) => a + b) /
            historyState.valueOrNull!.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryOrange,
                    child: Text(
                      initial,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          email,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Member since $memberSince',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '$totalScans',
                        style: const TextStyle(
                          color: AppColors.primaryOrange,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text('Total Scans'),
                    ],
                  ),
                  Container(width: 1, height: 38, color: AppColors.lightDivider),
                  Column(
                    children: [
                      Text(
                        avgScore.toStringAsFixed(1),
                        style: const TextStyle(
                          color: AppColors.primaryOrange,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text('Avg Health Score'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Settings', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('My Health Profile'),
                  leading: const Icon(Icons.favorite_border_rounded, color: AppColors.primaryOrange),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/account/profile'),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: mode == ThemeMode.dark,
                  onChanged: (v) {
                    ref.read(accountProvider).setTheme(v ? ThemeMode.dark : ThemeMode.light);
                  },
                  title: const Text('Dark Mode'),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('About Ingredex'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showAboutIngredex(context),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showPrivacyPolicy(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Account Management',
            style: AppTextStyles.heading3.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.highRiskBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.highRiskBorder,
                width: 1.2,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.highRisk.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.highRisk,
                  size: 22,
                ),
              ),
              title: Text(
                'Log Out',
                style: AppTextStyles.heading3.copyWith(
                  fontSize: 16,
                  color: AppColors.highRisk,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                'Sign out of your Ingredex session',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.highRisk.withValues(alpha: 0.8),
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.highRisk,
              ),
              onTap: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Log Out?'),
                    content: const Text('Are you sure you want to log out of Ingredex?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.highRisk,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Log Out'),
                      ),
                    ],
                  ),
                );
                if (ok == true) {
                  await ref.read(authNotifierProvider.notifier).logout();
                }
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
