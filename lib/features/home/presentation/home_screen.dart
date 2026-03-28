import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/snackbar_service.dart';
import '../../account/providers/account_provider.dart';
import '../../auth/providers/auth_provider.dart';
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
    final mode = ref.watch(themeProvider);
    final authState = ref.watch(authNotifierProvider).valueOrNull;
    final email = authState?.maybeWhen(
      authenticated: (user) => user.email,
      orElse: () => null,
    );
    final firstName = _firstNameFromEmail(email);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/app_logo_bgremove.png',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 12),
            Text(
              'Hi, $firstName! 👋',
              style: AppTextStyles.heading3.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
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
              SnackBarService.show('Notifications are not available yet.');
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryOrange, AppColors.lightOrange],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start a new analysis',
                    style: AppTextStyles.heading2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Scan barcode, read label, or type ingredients manually.',
                    style: AppTextStyles.body2.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => context.push('/scan/barcode'),
                      icon: const Icon(Icons.qr_code_scanner_rounded),
                      label: const Text('Quick Scan'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Scan options',
              style: AppTextStyles.heading3.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ScanOptionsCard(
                    title: 'Scan Barcode',
                    subtitle: 'Point at any barcode',
                    icon: Icons.qr_code_2_rounded,
                    onTap: () => context.push('/scan/barcode'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ScanOptionsCard(
                    title: 'Scan Label',
                    subtitle: 'Photo of ingredients',
                    icon: Icons.camera_alt_rounded,
                    onTap: () => context.push('/scan/ocr'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0.8,
              child: ListTile(
                onTap: () => context.push('/scan/manual'),
                leading: const Icon(
                  Icons.edit_note_rounded,
                  color: AppColors.primaryOrange,
                ),
                title: Text(
                  'Type ingredients manually',
                  style: AppTextStyles.body1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text('Paste from label or write your own list'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
