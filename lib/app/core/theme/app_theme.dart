
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,

    // appBarTheme
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.blackColor),
      leadingWidth: 20.w,
      titleTextStyle: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontFamily: FontsFamily.inter,
        fontSize: FontSize.s20,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
        foregroundColor: WidgetStateProperty.all(AppColors.whiteColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.h),
        ),
      ),
    ),

    // textStyle
    textTheme: TextTheme(
      labelMedium: GoogleFonts.inter(
        fontSize: FontSize.s13,
        fontWeight: FontWeights.regular,
        color: AppColors.grayColor,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: FontSize.s20,
        fontWeight: FontWeights.medium,
        color: AppColors.blackColor
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: FontSize.s16,
        fontWeight: FontWeights.medium,
        color: AppColors.blackColor,
      ),
      headlineSmall: GoogleFonts.roboto(
        fontSize: FontSize.s2,
        fontWeight: FontWeights.medium,
        color: AppColors.blackColor,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: FontSize.s16,
        fontWeight: FontWeights.medium,
        color: AppColors.whiteColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: FontSize.s16,
        fontWeight: FontWeights.medium,
        color: AppColors.blackColor
      ),
        bodyLarge: GoogleFonts.inter(
            fontSize: FontSize.s16,
            fontWeight: FontWeight.normal,
            color: AppColors.blackColor
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.unSelectedSectionGreyColor,
      showSelectedLabels: true,
      showUnselectedLabels: true
    ),
    inputDecorationTheme: _inputDecorationTheme(),
  );
}
InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
  border: const OutlineInputBorder(),
  floatingLabelBehavior: FloatingLabelBehavior.always,
  floatingLabelStyle: TextStyle(color: AppColors.grayColor),
  errorStyle: TextStyle(color: AppColors.errorColor),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.grayColor, width: 1),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.grayColor, width: 1),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.errorColor, width: 1),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.errorColor, width: 1),
  ),
  hintStyle: GoogleFonts.inter(fontWeight: FontWeights.medium,fontSize:FontSize.s14,color: AppColors.lightGrayColor),
);