import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ProfileOnboardingCard extends StatelessWidget {
  const ProfileOnboardingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primaryEmerald.withValues(alpha: 0.12)
            : AppColors.lowRiskBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryEmerald.withValues(alpha: 0.35),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.primaryEmerald,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.health_and_safety_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personalize Your Health Profile',
                  style: AppTextStyles.heading3.copyWith(
                    fontSize: 15,
                    color: isDark ? AppColors.lightOrange : AppColors.primaryEmeraldDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Add allergies & conditions for custom risk alerts.',
                  style: AppTextStyles.caption.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filledTonal(
            onPressed: () => context.push('/account/profile'),
            icon: const Icon(Icons.arrow_forward_rounded, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryEmerald.withValues(alpha: 0.2),
              foregroundColor: AppColors.primaryEmerald,
            ),
          ),
        ],
      ),
    );
  }
}
