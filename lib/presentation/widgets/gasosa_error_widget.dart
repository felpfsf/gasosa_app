import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class GasosaErrorWidget extends StatelessWidget {
  final String? title;
  final String message;
  final VoidCallback? onPressed;

  const GasosaErrorWidget({
    super.key,
    required this.message,
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.paddingMd,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.md,
          children: [
            const Icon(Icons.error, color: AppColors.error),
            if (title != null) Text(title!, style: AppTypography.titleSm),
            Text(
              message,
              style: AppTypography.textSmRegular,
              textAlign: TextAlign.center,
            ),
            if (onPressed != null)
              ElevatedButton(
                onPressed: onPressed,
                child: Text('Tentar novamente'),
              ),
          ],
        ),
      ),
    );
  }
}

