import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_styles.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.heading2),
        const SizedBox(height: 8),
        Text(subtitle, style: AppTextStyles.body2),
      ],
    );
  }
}
