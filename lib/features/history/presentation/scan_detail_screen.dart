import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/share_scan_text.dart';
import '../../../core/utils/user_facing_error.dart';
import '../../scan/data/models/scan_models.dart';
import '../providers/history_provider.dart';

class ScanDetailScreen extends ConsumerStatefulWidget {
  const ScanDetailScreen({super.key, required this.scanId});

  final String scanId;

  @override
  ConsumerState<ScanDetailScreen> createState() => _ScanDetailScreenState();
}

class _ScanDetailScreenState extends ConsumerState<ScanDetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final scanId = widget.scanId;
    if (scanId.isEmpty) {
      return const Scaffold(body: Center(child: Text('Missing scan id')));
    }

    final detailAsync = ref.watch(historyDetailProvider(scanId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Detail'),
        actions: [
          IconButton(
            tooltip: 'Share',
            onPressed: () async {
              final detail = ref
                  .read(historyDetailProvider(scanId))
                  .valueOrNull;
              if (detail == null) {
                return;
              }
              await Share.share(shareTextFromHistoryDetail(detail));
            },
            icon: const Icon(Icons.share_rounded),
          ),
          IconButton(
            onPressed: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Delete this scan?'),
                    content: const Text('This will remove it from history.'),
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
              if (ok == true) {
                await ref.read(historyProvider.notifier).delete(scanId);
                ref.invalidate(historyDetailProvider(scanId));
                if (context.mounted) context.pop();
              }
            },
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(userFacingError(e), textAlign: TextAlign.center),
          ),
        ),
        data: (detail) {
          final analysisMap = detail.analysisResult;
          final analysis = analysisMap == null
              ? null
              : AnalysisResult.fromJson(analysisMap);

          if (analysis != null) {
            final score = analysis.healthScore;
            final scoreColor = switch (score) {
              >= 7 => AppColors.success,
              >= 4 => AppColors.warning,
              _ => AppColors.error,
            };
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  detail.productName ?? 'Unnamed',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                Center(
                  child: Column(
                    children: [
                      _ScoreGauge(
                        score: score,
                        scoreColor: scoreColor,
                        risk: analysis.riskLevel,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(analysis.summary),
                  ),
                ),
                if (analysis.issues.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.error,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Concerning Ingredients',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...analysis.issues.map((item) {
                    final risk = item.risk.trim().toLowerCase();
                    final alpha = switch (risk) {
                      'high' => 0.28,
                      'medium' => 0.14,
                      'low' => 0.09,
                      _ => 0.10,
                    };
                    return Card(
                      color: AppColors.error.withValues(alpha: alpha),
                      child: ListTile(
                        title: Text(
                          item.ingredient,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(item.reason),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(
                              alpha: risk == 'high' ? 0.30 : 0.2,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(item.risk),
                        ),
                      ),
                    );
                  }),
                ],
                if (analysis.goodIngredients.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.success,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Beneficial Ingredients',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...analysis.goodIngredients.map(
                    (item) => Card(
                      color: AppColors.success.withValues(alpha: 0.08),
                      child: ListTile(
                        title: Text(
                          item.ingredient,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(item.benefit),
                      ),
                    ),
                  ),
                ],
                if (analysis.alternatives.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        color: AppColors.warning,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Alternatives',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...analysis.alternatives.map(
                    (item) => Card(
                      child: ListTile(
                        title: Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(item.reason),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Raw ingredients',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(detail.rawIngredients ?? '-'),
                    ],
                  ),
                ),
              ],
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                detail.productName ?? 'Unnamed',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text('Type: ${detail.scanType}'),
              const SizedBox(height: 12),
              const Text(
                'Raw ingredients',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(detail.rawIngredients ?? '-'),
            ],
          );
        },
      ),
    );
  }
}

class _ScoreGauge extends StatelessWidget {
  const _ScoreGauge({
    required this.score,
    required this.scoreColor,
    required this.risk,
  });

  final int score;
  final Color scoreColor;
  final String risk;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedRadialGauge(
          duration: const Duration(milliseconds: 1100),
          curve: Curves.easeOutCubic,
          radius: 100,
          value: score.toDouble(),
          axis: GaugeAxis(
            min: 0,
            max: 10,
            degrees: 270,
            style: GaugeAxisStyle(
              thickness: 14,
              background: Colors.transparent,
              segmentSpacing: 2,
            ),
            segments: [
              GaugeSegment(
                from: 0,
                to: score.toDouble(),
                color: scoreColor,
                cornerRadius: const Radius.circular(7),
              ),
              GaugeSegment(
                from: score.toDouble(),
                to: 10,
                color: scoreColor.withValues(alpha: 0.12),
              ),
            ],
          ),
          builder: (context, _, value) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${value.round()}',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w500,
                  color: scoreColor,
                  height: 1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'out of 10',
                style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 2),
              Text(
                'health score',
                style: TextStyle(
                  fontSize: 11,
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.6),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Risk pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: scoreColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: scoreColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                risk,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: scoreColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Tick row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(10, (i) {
            final filled = i < score;
            return Container(
              width: 20,
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: filled ? scoreColor : scoreColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
      ],
    );
  }
}
