import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

enum _RiskKind { low, medium, high, unknown }

/// Maps API risk strings (including synonyms and unknown) to consistent colors and labels.
class RiskBadge extends StatelessWidget {
  const RiskBadge({super.key, required this.risk});

  final String risk;

  static _RiskKind _kind(String raw) {
    final s = raw.trim().toLowerCase();
    if (s.isEmpty || s == 'unknown' || s == 'n/a') {
      return _RiskKind.unknown;
    }
    if (s.contains('high') || s.contains('severe') || s.contains('critical')) {
      return _RiskKind.high;
    }
    if (s.contains('medium') ||
        s.contains('moderate') ||
        s == 'mid' ||
        s.contains('med')) {
      return _RiskKind.medium;
    }
    if (s.contains('low') || s.contains('minimal') || s.contains('safe')) {
      return _RiskKind.low;
    }
    if (s == 'low') return _RiskKind.low;
    if (s == 'medium') return _RiskKind.medium;
    if (s == 'high') return _RiskKind.high;
    return _RiskKind.unknown;
  }

  static String _label(String raw, _RiskKind kind) {
    switch (kind) {
      case _RiskKind.low:
        return 'Low';
      case _RiskKind.medium:
        return 'Medium';
      case _RiskKind.high:
        return 'High';
      case _RiskKind.unknown:
        return raw.trim().isEmpty ? 'Unknown' : raw.trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    final kind = _kind(risk);
    final label = _label(risk, kind);
    final (Color bg, Color fg) = switch (kind) {
      _RiskKind.low => (
          AppColors.lowRisk.withValues(alpha: 0.16),
          AppColors.lowRisk,
        ),
      _RiskKind.medium => (
          AppColors.mediumRisk.withValues(alpha: 0.16),
          AppColors.mediumRisk,
        ),
      _RiskKind.high => (
          AppColors.highRisk.withValues(alpha: 0.16),
          AppColors.highRisk,
        ),
      _RiskKind.unknown => (
          Theme.of(context).colorScheme.surfaceContainerHighest,
          Theme.of(context).colorScheme.onSurfaceVariant,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: kind == _RiskKind.unknown
            ? Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
              )
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
