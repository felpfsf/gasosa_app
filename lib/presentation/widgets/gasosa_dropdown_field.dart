import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class GasosaDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final Widget? hint;
  final bool isExpanded;
  final bool enabled;
  final void Function()? onSaved;
  final bool isDense;

  const GasosaDropdownField({
    super.key,
    required this.label,
    this.value,
    this.items,
    required this.onChanged,
    this.validator,
    this.hint,
    this.isExpanded = true,
    this.enabled = true,
    this.onSaved,
    this.isDense = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(label, style: AppTypography.textSmBold),
        DropdownButtonFormField2<T>(
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          isExpanded: isExpanded,
          hint: hint,
          buttonStyleData: ButtonStyleData(
            height: 42,
            padding: EdgeInsets.only(left: AppSpacing.xs, right: AppSpacing.sm),
          ),
          decoration: InputDecoration(
            isDense: false,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.sm)),
            contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.sm),
          ),
        ),
      ],
    );
  }
}
