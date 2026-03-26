import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
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
    final name = item.productName ?? 'Unnamed product';
    final initial = name.characters.first.toUpperCase();
    final type = item.scanType.toUpperCase();
    final score = (item.analysisResult?['health_score'] as num?)?.toInt();
    final risk = item.analysisResult?['risk_level'] as String?;
    final summary = item.analysisResult?['summary'] as String?;
    final scheme = Theme.of(context).colorScheme;
    final scoreColor = switch (score ?? 0) {
      >= 7 => AppColors.success,
      >= 4 => AppColors.warning,
      >= 1 => AppColors.error,
      _ => scheme.onSurfaceVariant,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryOrange,
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
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
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _formatDate(item.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    if (summary != null && summary.trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        summary.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
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
                        color: AppColors.primaryOrange.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        risk == null || risk.trim().isEmpty
                            ? type
                            : '$type • ${risk.toUpperCase()}',
                        style: const TextStyle(
                          color: AppColors.primaryOrange,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scoreColor.withValues(alpha: 0.14),
                ),
                child: Center(
                  child: Text(
                    score?.toString() ?? '--',
                    style: TextStyle(
                      color: scoreColor,
                      fontWeight: FontWeight.w700,
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
