// lib/app/theme/theme.dart

import 'package:flutter/material.dart';

import 'AppColors.dart';

// Light Theme
final ThemeData lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(

      // primary: AppColors.primary,
      // secondary: AppColors.secondary,
      ),
  cardTheme: CardTheme(
    elevation: 2.5, // Controls the shadow intensity (default is 1)
    shadowColor:
        AppColors.greyColor.withValues(alpha: 0.5), // Custom shadow color
    shape: RoundedRectangleBorder(
      // Optional: Rounded corners
      borderRadius: BorderRadius.circular(12),
    ),
    color: AppColors.whiteColor,
    margin: const EdgeInsets.only(bottom: 15),
  ),
  scaffoldBackgroundColor: AppColors.whiteColor,
  // textTheme: TextTheme(),
  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   fillColor: AppColors.inputFillColor, // <- adjust for dark mode if needed
  //   border: OutlineInputBorder(
  //     borderRadius: AppBorderRadius.borderRadius12,
  //     borderSide: BorderSide(
  //       color: AppColors.grey,
  //       width: 1,
  //     ),
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderRadius: AppBorderRadius.borderRadius12,
  //     borderSide: BorderSide(
  //       color: AppColors.grey,
  //       width: 1,
  //     ),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderRadius: AppBorderRadius.borderRadius12,
  //     borderSide: BorderSide(
  //       color: AppColors.grey,
  //       width: 1.2,
  //     ),
  //   ),
  // ),

  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.whiteColor,
    textTheme: ButtonTextTheme.primary,
  ),
);

// Dark Theme
// final ThemeData darkTheme = ThemeData.dark().copyWith(
//   brightness: Brightness.dark,
//   colorScheme: ColorScheme.dark(
//     primary: AppColors.primary,
//     secondary: AppColors.secondary,
//   ),
//   cardTheme: CardTheme(
//     elevation: 2.5, // Controls the shadow intensity (default is 1)
//     shadowColor: AppColors.dark.withValues(alpha: 0.5), // Custom shadow color
//     shape: RoundedRectangleBorder(
//       // Optional: Rounded corners
//       borderRadius: AppBorderRadius.borderRadius12,
//     ),
//     color: const Color(0xFF010F1F),
//     margin: EdgeInsets.only(bottom: 15),
//   ),
//   scaffoldBackgroundColor: AppColors.darkBackground,
//   // textTheme: TextTheme(),
//   buttonTheme: ButtonThemeData(
//     buttonColor: AppColors.primary, // Button color
//     textTheme: ButtonTextTheme.primary,
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     filled: true,
//     fillColor: const Color(0xFF1C1B1F), // A dark grey fill, not white
//     enabledBorder: OutlineInputBorder(
//       borderRadius: AppBorderRadius.borderRadius12,
//       borderSide: BorderSide(
//         color: AppColors.grey,
//         width: 1,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: AppBorderRadius.borderRadius12,
//       borderSide: BorderSide(
//         color: AppColors.primary,
//         width: 1.2,
//       ),
//     ),
//     border: OutlineInputBorder(
//       borderRadius: AppBorderRadius.borderRadius12,
//       borderSide: BorderSide(
//         color: AppColors.grey,
//         width: 1,
//       ),
//     ),
//   ),
// );
