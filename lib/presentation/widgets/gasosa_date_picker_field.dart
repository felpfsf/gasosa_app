import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:intl/intl.dart';

class GasosaDatePickerField extends StatelessWidget {
  final String label;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime) onDateSelected;

  const GasosaDatePickerField({
    super.key,
    required this.label,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text:
          initialDate?.toString() != null
              ? DateFormat('dd/MM/yyyy').format(initialDate!)
              : '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        AppSpacing.gap8,
        GestureDetector(
          onTap: () async {
            final now = DateTime.now();
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate ?? now,
              firstDate: firstDate ?? DateTime(now.year - 5),
              lastDate: lastDate ?? DateTime(now.year + 5),
              builder:
                  (context, child) =>
                      Theme(data: Theme.of(context), child: child!),
            );

            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              style: AppTypography.textMdRegular,
              decoration: InputDecoration(
                hintText: 'dd/mm/yyyy',
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
