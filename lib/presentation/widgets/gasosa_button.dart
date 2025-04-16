import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class GasosaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isExpanded;
  final bool isDisabled;
  final Color? backgroundColor;

  const GasosaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isExpanded = true,
    this.isDisabled = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final child = ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: AppColors.text,
        textStyle: AppTypography.textSmBold,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.radiusMd),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.lg,
        ),
      ),
      child: Text(label),
    );

    if (isExpanded) {
      return SizedBox(width: double.infinity, child: child);
    }

    return child;
  }
}
