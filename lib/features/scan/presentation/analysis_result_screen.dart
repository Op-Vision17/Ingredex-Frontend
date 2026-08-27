import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
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
  int _selectedTab = 0; // 0: Issues, 1: Beneficial, 2: Insights, 3: Alternatives

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _appear = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _scoreColor(double score) {
    if (score >= 75) return AppColors.lowRisk;
    if (score >= 40) return AppColors.mediumRisk;
    return AppColors.highRisk;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
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
    final insights = analysis?.userInsights ?? const <UserInsight>[];
    final scoreColor = _scoreColor(score);
    final scanId = external?.scanId ?? lastResult?.scanId;
    final heroTag =
        'health-score-${scanId ?? identityHashCode(analysis)}-${score.toStringAsFixed(0)}';

    final allSources = {
      ...sourcesUsed,
      ...issues.map((e) => e.sourceDomain).where((d) => d.trim().isNotEmpty),
      ...good.map((e) => e.sourceDomain).where((d) => d.trim().isNotEmpty),
    }.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Analysis'),
        actions: [
          IconButton(
            tooltip: 'Back to Home',
            icon: const Icon(Icons.home_outlined),
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _appear,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
          children: [
            // Product Title
            Text(
              productName,
              style: AppTextStyles.heading1.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            const SizedBox(height: 14),

            // Hero Score Gauge Card
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
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
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.04)
                            : AppColors.lightBackground,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded,
                            size: 20,
                            color: scoreColor,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              summary,
                              style: AppTextStyles.body2.copyWith(
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Segmented Category Bar (Personal Insights First)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _CategoryPill(
                    label: 'Insights (${insights.length})',
                    icon: Icons.lightbulb_outline_rounded,
                    isSelected: _selectedTab == 0,
                    color: AppColors.accentAmber,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                  const SizedBox(width: 8),
                  _CategoryPill(
                    label: 'Issues (${issues.length})',
                    icon: Icons.warning_amber_rounded,
                    isSelected: _selectedTab == 1,
                    color: AppColors.highRisk,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                  const SizedBox(width: 8),
                  _CategoryPill(
                    label: 'Safe (${good.length})',
                    icon: Icons.eco_outlined,
                    isSelected: _selectedTab == 2,
                    color: AppColors.lowRisk,
                    onTap: () => setState(() => _selectedTab = 2),
                  ),
                  if (alternatives.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    _CategoryPill(
                      label: 'Alternatives (${alternatives.length})',
                      icon: Icons.swap_horiz_rounded,
                      isSelected: _selectedTab == 3,
                      color: AppColors.accentTangerine,
                      onTap: () => setState(() => _selectedTab = 3),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Active Tab Content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _buildTabContent(
                selectedTab: _selectedTab,
                issues: issues,
                good: good,
                insights: insights,
                alternatives: alternatives,
                isDark: isDark,
              ),
            ),
            const SizedBox(height: 16),

            // Verified Scientific Sources
            SourcesButton(sources: allSources),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/home'),
                  icon: const Icon(Icons.arrow_back_rounded, size: 18),
                  label: const Text('Back to Home'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/scan/ocr'),
                  icon: const Icon(Icons.camera_alt_rounded, size: 18),
                  label: const Text('Scan Another'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent({
    required int selectedTab,
    required List<IngredientIssue> issues,
    required List<GoodIngredient> good,
    required List<UserInsight> insights,
    required List<Alternative> alternatives,
    required bool isDark,
  }) {
    switch (selectedTab) {
      case 0:
        return UserInsightsCard(
          key: const ValueKey(0),
          insights: insights,
        );
      case 1:
        if (issues.isEmpty) {
          return const _EmptySectionCard(
            icon: Icons.check_circle_rounded,
            color: AppColors.lowRisk,
            title: 'No Problematic Additives Found',
            subtitle: 'This product does not contain high or medium risk flagged additives.',
          );
        }
        return Column(
          key: const ValueKey(1),
          children: issues.map((item) => _IssueCard(issue: item, isDark: isDark)).toList(),
        );
      case 2:
        if (good.isEmpty) {
          return const _EmptySectionCard(
            icon: Icons.eco_outlined,
            color: AppColors.accentAmber,
            title: 'No Notable Nutrients Highlighted',
            subtitle: 'Ingredients are neutral standard components.',
          );
        }
        return Column(
          key: const ValueKey(2),
          children: good.map((item) => _GoodIngredientCard(item: item, isDark: isDark)).toList(),
        );
      case 3:
        if (alternatives.isEmpty) {
          return const _EmptySectionCard(
            icon: Icons.swap_horiz_rounded,
            color: AppColors.accentTangerine,
            title: 'No Alternatives Needed',
            subtitle: 'This product is already a clean choice.',
          );
        }
        return Column(
          key: const ValueKey(3),
          children: alternatives
              .map((item) => _AlternativeCard(alternative: item, isDark: isDark))
              .toList(),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: isDark ? 0.25 : 0.14)
                : (isDark ? AppColors.darkCard : AppColors.lightCard),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? color
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? color : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.body2.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? color
                      : (isDark ? AppColors.darkText : AppColors.lightText),
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
            style: const GaugeAxisStyle(
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

class _IssueCard extends StatelessWidget {
  const _IssueCard({required this.issue, required this.isDark});

  final IngredientIssue issue;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final riskLower = issue.risk.trim().toLowerCase();
    final isHigh = riskLower == 'high';
    final cardBorderColor = isHigh ? AppColors.highRisk : AppColors.mediumRisk;
    final cardBgColor = isHigh
        ? (isDark ? AppColors.darkHighRiskBg.withValues(alpha: 0.3) : AppColors.highRiskBg)
        : (isDark ? AppColors.darkMediumRiskBg.withValues(alpha: 0.3) : AppColors.mediumRiskBg);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cardBorderColor.withValues(alpha: 0.4), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  issue.ingredient,
                  style: AppTextStyles.heading3.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: cardBorderColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  issue.risk.toUpperCase(),
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            issue.reason,
            style: AppTextStyles.body2.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              height: 1.4,
            ),
          ),
          if (issue.sourceDomain.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.verified_outlined, size: 14, color: AppColors.primaryEmerald),
                const SizedBox(width: 4),
                Text(
                  'Cited by ${issue.sourceDomain}',
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.lightOrange : AppColors.primaryEmeraldDark,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _GoodIngredientCard extends StatelessWidget {
  const _GoodIngredientCard({required this.item, required this.isDark});

  final GoodIngredient item;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkLowRiskBg.withValues(alpha: 0.3)
            : AppColors.lowRiskBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.lowRisk.withValues(alpha: 0.4),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_rounded, size: 18, color: AppColors.lowRisk),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.ingredient,
                  style: AppTextStyles.heading3.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.lowRisk,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'BENEFICIAL',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            item.benefit,
            style: AppTextStyles.body2.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              height: 1.4,
            ),
          ),
          if (item.sourceDomain.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.verified_outlined, size: 14, color: AppColors.primaryEmerald),
                const SizedBox(width: 4),
                Text(
                  'Source: ${item.sourceDomain}',
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.lightOrange : AppColors.primaryEmeraldDark,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _AlternativeCard extends StatelessWidget {
  const _AlternativeCard({required this.alternative, required this.isDark});

  final Alternative alternative;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accentTangerine.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.swap_horiz_rounded,
              color: AppColors.accentTangerine,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alternative.name,
                  style: AppTextStyles.heading3.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alternative.reason,
                  style: AppTextStyles.body2.copyWith(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySectionCard extends StatelessWidget {
  const _EmptySectionCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppTextStyles.heading3.copyWith(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.caption.copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
