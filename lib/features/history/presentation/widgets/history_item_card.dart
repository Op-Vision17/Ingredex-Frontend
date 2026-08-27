import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/history_models.dart';

class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({super.key, required this.item, this.onTap});

  final HistoryItem item;
  final VoidCallback? onTap;

  String _formatDate(String raw) {
    final dt = DateTime.tryParse(raw);
    if (dt == null) return raw;
    return DateFormat('dd MMM, hh:mm a').format(dt.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final name = item.productName ?? 'Unnamed product';
    final initial = name.characters.first.toUpperCase();
    final type = item.scanType.toUpperCase();
    final score = (item.analysisResult?['health_score'] as num?)?.toInt();
    final risk = item.analysisResult?['risk_level'] as String?;
    final summary = item.analysisResult?['summary'] as String?;
    final scoreColor = switch (score ?? 0) {
      >= 70 => AppColors.lowRisk,
      >= 40 => AppColors.mediumRisk,
      >= 1 => AppColors.highRisk,
      _ => isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryEmerald.withValues(alpha: isDark ? 0.20 : 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryEmerald.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: AppTextStyles.heading3.copyWith(
                      color: isDark ? AppColors.lightOrange : AppColors.primaryEmeraldDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading3.copyWith(
                        fontSize: 15,
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _formatDate(item.createdAt),
                      style: AppTextStyles.caption.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    if (summary != null && summary.trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        summary.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : AppColors.lightBackground,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                      ),
                      child: Text(
                        risk == null || risk.trim().isEmpty
                            ? type
                            : '$type • ${risk.toUpperCase()}',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scoreColor.withValues(alpha: isDark ? 0.20 : 0.14),
                  border: Border.all(
                    color: scoreColor.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    score?.toString() ?? '--',
                    style: AppTextStyles.heading3.copyWith(
                      fontSize: 15,
                      color: scoreColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
