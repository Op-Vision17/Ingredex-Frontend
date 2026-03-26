import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/user_facing_error.dart';
import '../data/models/history_models.dart';
import '../providers/history_provider.dart';
import 'widgets/history_item_card.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _scrollController = ScrollController();
  final _deletingIds = <String>{};
  String _filter = 'All';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 220) {
        ref.read(historyProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> _confirmDelete(String id) async {
    if (_deletingIds.contains(id)) return false; // block duplicate
    setState(() => _deletingIds.add(id));
    try {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete history item?'),
            content: const Text('This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
      if (ok != true) return false;
      await ref.read(historyProvider.notifier).delete(id);
      return true;
    } catch (_) {
      if (!mounted) return false;
      return false;
    } finally {
      if (mounted) setState(() => _deletingIds.remove(id));
    }
  }

  List<HistoryItem> _applyFilter(List<HistoryItem> items) {
    if (_filter == 'All') return items;
    final acceptedTypes = switch (_filter) {
      'Manual' => {'analysis'},
      'OCR' => {'ocr'},
      'Barcode' => {'barcode'},
      _ => <String>{},
    };
    if (acceptedTypes.isEmpty) return items;
    return items
        .where((e) => acceptedTypes.contains(e.scanType.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(historyProvider);
    final statsAsync = ref.watch(historyStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(historyProvider.notifier).refresh(),
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          children: [
            _StatsCard(
              statsAsync: statsAsync,
              onRetryStats: () {
                ref.invalidate(historyStatsProvider);
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: ['All', 'Barcode', 'OCR', 'Manual']
                  .map(
                    (chip) => ChoiceChip(
                      label: Text(chip),
                      selected: _filter == chip,
                      onSelected: (_) => setState(() => _filter = chip),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            historyAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(userFacingError(e), textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: () => ref.invalidate(historyProvider),
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
              data: (items) {
                final filtered = _applyFilter(items);
                if (filtered.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: _EmptyHistoryState(),
                  );
                }
                return Column(
                  children: [
                    ...filtered.map(
                      (item) => Dismissible(
                        key: ValueKey(item.id),
                        direction: _deletingIds.contains(item.id)
                            ? DismissDirection.none
                            : DismissDirection.endToStart,
                        confirmDismiss: (_) async {
                          return _confirmDelete(item.id);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.delete_rounded,
                            color: AppColors.error,
                          ),
                        ),
                        child: HistoryItemCard(
                          item: item,
                          onTap: () => context.push('/history/${item.id}'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.statsAsync, required this.onRetryStats});

  final AsyncValue<HistoryStats> statsAsync;
  final VoidCallback onRetryStats;

  @override
  Widget build(BuildContext context) {
    return statsAsync.when(
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: LinearProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(userFacingError(error))),
              TextButton(onPressed: onRetryStats, child: const Text('Retry')),
            ],
          ),
        ),
      ),
      data: (stats) {
        final byType = stats.byScanType;
        final total = stats.totalScans;
        final scheme = Theme.of(context).colorScheme;
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryOrange, AppColors.lightOrange],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.insights_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Total scans',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: total.toDouble()),
                        duration: const Duration(milliseconds: 700),
                        builder: (context, value, child) => Text(
                          value.toInt().toString(),
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: byType.entries
                      .map(
                        (e) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryOrange.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '${e.key}: ${e.value}',
                            style: TextStyle(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmptyHistoryState extends StatelessWidget {
  const _EmptyHistoryState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.history_toggle_off_rounded,
          size: 84,
          color: AppColors.primaryOrange.withValues(alpha: 0.65),
        ),
        const SizedBox(height: 12),
        Text(
          'No scans yet',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
