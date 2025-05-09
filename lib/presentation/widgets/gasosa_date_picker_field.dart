import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:intl/intl.dart';

class GasosaDatePickerField extends StatelessWidget {
  final String label;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime) onDateSelected;
  final String? Function(DateTime?)? validator;

  const GasosaDatePickerField({
    super.key,
    required this.label,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: initialDate,
      validator: validator,
      builder: (FormFieldState<DateTime> state) {
        final formattedDate = state.value != null ? DateFormat('dd/MM/yyyy').format(state.value!) : '';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.sm,
          children: [
            Text(label, style: AppTypography.textSmBold),
            GestureDetector(
              onTap: () async {
                final now = DateTime.now();
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: state.value ?? now,
                  firstDate: firstDate ?? DateTime(now.year - 5),
                  lastDate: lastDate ?? DateTime(now.year + 5),
                  builder: (context, child) => Theme(data: Theme.of(context), child: child!),
                );

                if (pickedDate != null) {
                  state.didChange(pickedDate);
                  onDateSelected(pickedDate);
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: formattedDate),
                  style: AppTypography.textMdRegular,
                  decoration: InputDecoration(
                    hintText: '01/01/2025',
                    suffixIcon: Icon(Icons.calendar_today),
                    hintStyle: AppTypography.textSmRegular.copyWith(color: AppColors.text.withValues(alpha: .6)),
                    border: const OutlineInputBorder(),
                    errorText: state.errorText,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
