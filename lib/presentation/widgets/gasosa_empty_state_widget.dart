import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class GaososaEmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? imagePath;
  final VoidCallback? onPressed;
  final String actionLabel;

  const GaososaEmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.imagePath,
    this.onPressed,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.paddingMd,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.md,
          children: [
            // if (imagePath != null)
            //   Image.asset(
            //     imagePath!,
            //     width: 120,
            //     height: 120,
            //     fit: BoxFit.contain,
            //   ),
            const Icon(Icons.hourglass_bottom, color: AppColors.border, size: 44,),
            Text(
              title,
              style: AppTypography.titleMd,
              textAlign: TextAlign.center,
            ),
            Text(
              message,
              style: AppTypography.textMdRegular,
              textAlign: TextAlign.center,
            ),
            if (onPressed != null)
              ElevatedButton(onPressed: onPressed, child: Text(actionLabel)),
          ],
        ),
      ),
    );
  }
}
