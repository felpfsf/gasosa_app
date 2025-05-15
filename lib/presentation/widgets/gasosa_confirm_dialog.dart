import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class GasosaConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;

  const GasosaConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.md,
          children: [
            Icon(Icons.warning_amber_rounded, size: 40, color: Theme.of(context).colorScheme.error),
            Text(title, textAlign: TextAlign.center, style: AppTypography.textMdBold),
            Text(message, textAlign: TextAlign.center, style: AppTypography.textMdRegular),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpacing.md,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(cancelText, style: AppTypography.textSmBold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pop(true);
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: AppColors.text,
                    textStyle: AppTypography.textSmBold,
                    shape: RoundedRectangleBorder(borderRadius: AppSpacing.radiusMd),
                  ),
                  child: Text(confirmText, style: AppTypography.textSmBold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
