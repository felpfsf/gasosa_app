import 'package:flutter/material.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_confirm_dialog.dart';

Future<bool> showGasosaConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmText,
  required String cancelText,
}) async {
  final result = await showDialog(
    context: context,
    builder:
        (_) => GasosaConfirmDialog(
          title: title,
          message: message,
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: () => Navigator.of(context).pop(true),
        ),
  );

  return result ?? false;
}
