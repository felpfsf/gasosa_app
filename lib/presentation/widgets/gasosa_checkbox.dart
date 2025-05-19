import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class GasosaCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool?)? onChanged;
  final Widget? subtitle;
  final EdgeInsets padding;

  const GasosaCheckbox({
    super.key,
    required this.title,
    this.value = false,
    this.onChanged,
    this.subtitle,
    this.padding = const EdgeInsets.symmetric(vertical: AppSpacing.sm),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: AppTypography.textSmBold),
        subtitle: subtitle,
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
        checkColor: AppColors.text,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.sm)),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
