import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../data/models/scan_models.dart';
import '../providers/scan_provider.dart';
import 'widgets/sources_button.dart';
import 'widgets/user_insights_card.dart';

class AnalysisResultScreen extends ConsumerStatefulWidget {
  const AnalysisResultScreen({super.key, this.result});

  final Object? result;

  @override
  ConsumerState<AnalysisResultScreen> createState() =>
      _AnalysisResultScreenState();
}

class _AnalysisResultScreenState extends ConsumerState<AnalysisResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _appear;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _appear = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _scoreColor(double score) {
    if (score >= 70) return AppColors.success;
    if (score >= 40) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final lastResult = ref.watch(lastAnalysisProvider);
    final external = widget.result is AnalyzeResponse
        ? widget.result as AnalyzeResponse
        : null;
    final analysis = external?.analysis ?? lastResult?.analysis;
    final score = analysis?.healthScore.toDouble() ?? 0;
    final risk = analysis?.riskLevel ?? 'Unknown';
    final summary = analysis?.summary ?? 'No summary available';
    final productName =
        external?.productName ?? lastResult?.productName ?? 'Scanned Product';
    final issues = analysis?.issues ?? const <IngredientIssue>[];
    final good = analysis?.goodIngredients ?? const <GoodIngredient>[];
    final alternatives = analysis?.alternatives ?? const <Alternative>[];
    final sourcesUsed = analysis?.sourcesUsed ?? const <String>[];
    final scoreColor = _scoreColor(score);
    final scanId = external?.scanId ?? lastResult?.scanId;
    final heroTag =
        'health-score-${scanId ?? productName}-${score.toStringAsFixed(0)}';

    return Scaffold(
      appBar: AppBar(title: const Text('Analysis Result')),
      body: FadeTransition(
        opacity: _appear,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
          children: [
            Text(
              productName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            Center(
              child: Column(
                children: [
                  Hero(
                    tag: heroTag,
                    child: _ScoreGauge(
                      score: score.toInt(),
                      scoreColor: scoreColor,
                      risk: risk,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SlideInCard(
              delay: 80,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(summary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (analysis != null) UserInsightsCard(insights: analysis.userInsights),
            if (issues.isNotEmpty) ...[
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
              ...issues.map((item) {
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.reason),
                        if (item.sourceDomain.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Source: ${item.sourceDomain}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ]
                      ],
                    ),
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
            if (good.isNotEmpty) ...[
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
              ...good.map(
                (item) => Card(
                  color: AppColors.success.withValues(alpha: 0.08),
                  child: ListTile(
                    title: Text(
                      item.ingredient,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.benefit),
                        if (item.sourceDomain.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Source: ${item.sourceDomain}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.success,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            ],
            if (alternatives.isNotEmpty) ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.primaryOrange,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Healthier Alternatives',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...alternatives.map(
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
            SourcesButton(sources: sourcesUsed),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Back to home'),
                ),
              ),
            ],
          ),
        ),
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
            max: 100,
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
                to: 100,
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
                'out of 100',
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(10, (i) {
            final filled = i < (score / 10);
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

class _SlideInCard extends StatefulWidget {
  const _SlideInCard({required this.child, this.delay = 0});

  final Widget child;
  final int delay;

  @override
  State<_SlideInCard> createState() => _SlideInCardState();
}

class _SlideInCardState extends State<_SlideInCard> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 420),
      offset: _visible ? Offset.zero : const Offset(0, 0.08),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 420),
        opacity: _visible ? 1 : 0,
        child: widget.child,
      ),
    );
  }
}
