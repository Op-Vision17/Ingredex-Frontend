import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

enum HealthScoreSize { small, medium, large }

class HealthScoreWidget extends StatefulWidget {
  const HealthScoreWidget({
    super.key,
    required this.score,
    this.size = HealthScoreSize.medium,
  });

  final double score;
  final HealthScoreSize size;

  @override
  State<HealthScoreWidget> createState() => _HealthScoreWidgetState();
}

class _HealthScoreWidgetState extends State<HealthScoreWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..forward();
    _progress = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _size => switch (widget.size) {
        HealthScoreSize.small => 40,
        HealthScoreSize.medium => 80,
        HealthScoreSize.large => 120,
      };

  Color _color(double score) {
    if (score >= 7) return AppColors.success;
    if (score >= 4) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(widget.score);
    final textSize = switch (widget.size) {
      HealthScoreSize.small => 12.0,
      HealthScoreSize.medium => 18.0,
      HealthScoreSize.large => 26.0,
    };

    return SizedBox(
      width: _size,
      height: _size,
      child: AnimatedBuilder(
        animation: _progress,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: (widget.score / 10).clamp(0, 1) * _progress.value,
                strokeWidth: widget.size == HealthScoreSize.small ? 4 : 8,
                color: color,
                backgroundColor: color.withValues(alpha: 0.2),
              ),
              Text(
                widget.score.toStringAsFixed(0),
                style: TextStyle(
                  color: color,
                  fontSize: textSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

