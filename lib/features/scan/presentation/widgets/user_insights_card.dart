import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/scan_models.dart';

class UserInsightsCard extends StatelessWidget {
  const UserInsightsCard({super.key, required this.insights});
  final List<UserInsight> insights;

  @override
  Widget build(BuildContext context) {
    if (insights.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...insights.asMap().entries.map((entry) {
          final index = entry.key;
          final insight = entry.value;

          final impactLower = insight.impact.toLowerCase();
          final isNegative = impactLower == 'negative';
          final isPositive = impactLower == 'positive';

          final isVerdict = index == 0 ||
              insight.title.contains('🟢') ||
              insight.title.contains('🟡') ||
              insight.title.contains('🔴') ||
              insight.title.toLowerCase().contains('snacking') ||
              insight.title.toLowerCase().contains('eating') ||
              insight.title.toLowerCase().contains('dangerous');

          final color = isNegative
              ? AppColors.highRisk
              : (isPositive ? AppColors.lowRisk : AppColors.mediumRisk);

          final bgColor = isNegative
              ? (isDark ? AppColors.darkHighRiskBg.withValues(alpha: 0.35) : AppColors.highRiskBg)
              : (isPositive
                  ? (isDark ? AppColors.darkLowRiskBg.withValues(alpha: 0.35) : AppColors.lowRiskBg)
                  : (isDark ? AppColors.darkMediumRiskBg.withValues(alpha: 0.35) : AppColors.mediumRiskBg));

          final icon = isNegative
              ? Icons.warning_amber_rounded
              : (isPositive ? Icons.check_circle_outline_rounded : Icons.info_outline_rounded);

          if (isVerdict) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(icon, color: color, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          insight.title,
                          style: AppTextStyles.heading3.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    insight.description,
                    style: AppTextStyles.body2.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      height: 1.45,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight.title,
                        style: AppTextStyles.heading3.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.darkText : AppColors.lightText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        insight.description,
                        style: AppTextStyles.caption.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                          height: 1.4,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
