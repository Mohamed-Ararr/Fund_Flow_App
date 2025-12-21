import 'package:flutter/material.dart';

import '../AppColors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.whiteColor,
    canvasColor: AppColors.lightGreyColor,
    primaryColor: AppColors.primaryDark,
    dividerColor: AppColors.dividerLight,
    // fontFamily: "Quicksand",
    colorScheme: const ColorScheme.light(
      primary: AppColors.darkBlueColor,
      secondary: AppColors.successTeal,
      error: AppColors.warningOrange,
      surface: Color.fromARGB(255, 250, 250, 250),
      onSurface: AppColors.darkText,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.darkText),
      titleLarge: TextStyle(
        color: AppColors.darkBlueColor,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    canvasColor: const Color(0xFF121212),
    primaryColor: AppColors.successTeal,
    dividerColor: Colors.white12,
    // fontFamily: "Quicksand",
    colorScheme: const ColorScheme.dark(
      primary: AppColors.successTeal,
      secondary: AppColors.orangeColor,
      error: AppColors.warningOrange,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
