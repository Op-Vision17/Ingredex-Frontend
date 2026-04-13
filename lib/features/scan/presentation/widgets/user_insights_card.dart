import 'package:flutter/material.dart';
import 'package:ingredex/core/constants/app_colors.dart';
import '../../data/models/scan_models.dart';

class UserInsightsCard extends StatelessWidget {
  const UserInsightsCard({super.key, required this.insights});
  final List<UserInsight> insights;

  @override
  Widget build(BuildContext context) {
    if (insights.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Personalized Insights',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...insights.map((insight) {
          final isNegative = insight.impact.toLowerCase() == 'negative';
          final isPositive = insight.impact.toLowerCase() == 'positive';
          
          final color = isNegative 
              ? AppColors.error 
              : (isPositive ? AppColors.success : Colors.blueGrey);
          final icon = isNegative 
              ? Icons.warning_rounded 
              : (isPositive ? Icons.check_circle_rounded : Icons.info_rounded);
              
          return Card(
            color: color.withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: color.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          insight.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color.withValues(alpha: 0.9),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          insight.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 4),
      ],
    );
  }
}
