import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static final textSmRegular = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static final textSmMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static final textSmBold = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static final textMdRegular = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static final textMdBold = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static final textLgRegular = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static final textLgBold = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static final titleSm = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static final titleMd = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static final titleLg = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );
}
