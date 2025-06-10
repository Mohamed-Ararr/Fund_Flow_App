import 'package:flutter/material.dart';
import 'package:fundflow/Core/AppColors.dart';

class AppTextStyles {
  static TextStyle headline1(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: "Quicksand",
          ) ??
      const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: "Quicksand",
      );

  static TextStyle headline2(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: "Quicksand",
          ) ??
      const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        fontFamily: "Quicksand",
      );

  static TextStyle headline3(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "Quicksand",
          ) ??
      const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: "Quicksand",
      );

  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            fontFamily: "Quicksand",
          ) ??
      const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        fontFamily: "Quicksand",
      );

  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontFamily: "Quicksand",
          ) ??
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: "Quicksand",
      );

  static TextStyle caption(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: "Quicksand",
          ) ??
      const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: "Quicksand",
      );

  static TextStyle buttonText(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Quicksand",
          ) ??
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: "Quicksand",
      );
}

class AppFonts {
  static TextStyle appTitleStyle = const TextStyle(
    fontSize: 40,
  );

  static TextStyle appTitleInHomeViewStyle = const TextStyle(
    fontFamily: "Cinzel",
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle userNameStyle18 = const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle userWelcomeStyle16 = const TextStyle(
    fontSize: 16,
    color: Colors.white70,
    fontWeight: FontWeight.w600,
  );

  static TextStyle font11Bold = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font11BoldLightGrey = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: AppColors.greyColor,
  );

  static TextStyle font14BoldLightGrey = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.greyColor,
    wordSpacing: 2,
  );

  static TextStyle font12Bold = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font12BoldWhite = const TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font12White = const TextStyle(
    fontSize: 12,
    color: AppColors.greyColor,
  );

  static TextStyle font14Bold = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font17Bold = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font18Bold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font18BoldWhite = const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font18BoldCinzel = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: "Cinzel",
  );

  static TextStyle font16BoldCinzel = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: "Cinzel",
  );

  static TextStyle font16BoldCinzelWhite = const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: "Cinzel",
  );

  static TextStyle font15Bold = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font16Bold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font16BoldWhite = const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font22Bold = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font22BoldBlack = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle font20BoldBlack = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle font22WhiteBold = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle sectionTitleStyle = const TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.bold,
  );
}
