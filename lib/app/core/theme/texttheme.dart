import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoco_stay_student/app/core/env.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class AppTextTheme {
  static final textTheme = TextTheme(
    headlineSmall: GoogleFonts.roboto(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColor.textblack,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColor.textblack,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColor.textblack,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.textblack,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.textblack,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.textblack,
    ),

    labelMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.textblack,
    ),

    // quicksand text with textprimary color
    displaySmall: GoogleFonts.quicksand(
      fontSize: screenwidth * 0.03,
      fontWeight: FontWeight.w500,
      color: AppColor.textprimary,
    ),
    bodyLarge: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.textprimary,
    ),

    labelSmall: GoogleFonts.quicksand(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColor.textprimary,
    ),

    displayMedium: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.textprimary,
    ),
    headlineMedium: GoogleFonts.quicksand(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColor.textprimary,
    ),
    displayLarge: GoogleFonts.quicksand(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.textprimary,
    ),
    labelLarge: GoogleFonts.quicksand(
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: AppColor.textprimary,
    ),
  );
}
