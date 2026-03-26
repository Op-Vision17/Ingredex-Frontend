import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

enum AppButtonVariant { primary, outlined, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.variant = AppButtonVariant.primary,
    this.enabled = true,
    this.foregroundColor,
    this.borderColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final AppButtonVariant variant;
  final bool enabled;
  final Color? foregroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final canTap = enabled && !loading && onPressed != null;
    final progressColor = variant == AppButtonVariant.primary
        ? Colors.white
        : Theme.of(context).colorScheme.primary;
    final buttonLabelStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
      height: 1.15,
      leadingDistribution: TextLeadingDistribution.even,
    );
    final child = loading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: progressColor,
            ),
          )
        : Text(label, style: buttonLabelStyle);

    final button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
        onPressed: canTap ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white70,
        ),
        child: child,
      ),
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: canTap ? onPressed : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor ?? AppColors.primaryOrange),
          foregroundColor: foregroundColor ?? AppColors.primaryOrange,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: canTap ? onPressed : null,
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor ?? AppColors.primaryOrange,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: child,
      ),
    };

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: DecoratedBox(
        decoration: variant == AppButtonVariant.primary
            ? BoxDecoration(
                gradient: canTap
                    ? const LinearGradient(
                        colors: [
                          AppColors.lightOrange,
                          AppColors.primaryOrange,
                        ],
                      )
                    : LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade400],
                      ),
                borderRadius: BorderRadius.circular(14),
              )
            : const BoxDecoration(),
        child: button,
      ),
    );
  }
}
