import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class AppColors {
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1F1F1F);
  static const Color primary = Color(0xFF7F39FB);
  static const Color accent = Color(0xFFA3FFBE);
  static const Color text = Color(0xFFF1F1F1);
  static const Color error = Color(0xFFFF5F5F);
  static const Color border = Color(0xFF2B2B2B);
  static const Color success = Color(0xFF00FF00);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.background,
      error: AppColors.error,
    ),
    textTheme: TextTheme(
      headlineLarge: AppTypography.titleLg,
      headlineMedium: AppTypography.titleMd,
      headlineSmall: AppTypography.titleSm,
      titleLarge: AppTypography.textLgBold,
      titleMedium: AppTypography.textMdBold,
      titleSmall: AppTypography.textSmBold,
      bodyLarge: AppTypography.textMdRegular,
      bodyMedium: AppTypography.textSmMedium,
      bodySmall: AppTypography.textSmRegular,
      labelLarge: AppTypography.textSmBold,
      labelMedium: AppTypography.textSmMedium,
      labelSmall: AppTypography.textSmRegular,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: AppTypography.textSmRegular.copyWith(
        color: AppColors.text.withValues(alpha: .6),
      ),
      errorStyle: AppTypography.textSmRegular.copyWith(color: AppColors.error),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,
        textStyle: AppTypography.textSmBold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
  );
}
