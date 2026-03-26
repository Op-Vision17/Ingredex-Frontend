import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/user_facing_error.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../history/providers/history_provider.dart';
import '../../../history/presentation/widgets/history_item_card.dart';

class RecentScansSection extends ConsumerWidget {
  const RecentScansSection({super.key});

  Widget _loadingShimmer(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = Color.lerp(scheme.surfaceContainerHighest, scheme.onSurface, 0.08)!;
    final highlight =
        Color.lerp(scheme.surfaceContainerHighest, scheme.onSurface, 0.02)!;
    return Column(
      children: List.generate(
        3,
        (_) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Shimmer.fromColors(
            baseColor: base,
            highlightColor: highlight,
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.inventory_2_rounded,
            size: 56,
            color: AppColors.primaryOrange.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 10),
          Text(
            'No scans yet',
            style: AppTextStyles.body1.copyWith(
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentAsync = ref.watch(historyListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Recent Scans',
              style: AppTextStyles.heading3.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => context.go('/history'),
              child: const Text('See all'),
            ),
          ],
        ),
        recentAsync.when(
          loading: () => _loadingShimmer(context),
          error: (e, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userFacingError(e),
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => ref.invalidate(historyProvider),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Retry'),
                  ),
                ],
              ),
          data: (items) {
            final recent = items.take(3).toList();
            if (recent.isEmpty) return _emptyState(context);
            return Column(
              children: recent
                  .map(
                    (item) => HistoryItemCard(
                      item: item,
                      onTap: () => context.push('/history/${item.id}'),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
