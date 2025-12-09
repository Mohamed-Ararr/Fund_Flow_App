import "package:flutter/material.dart";

class AppColors {
  static const Color greyColor = Color(0xff708090);
  static const Color lightGreyColor = Color(0xffECECEC);
  static const Color orangeColor = Color(0xFFFFAC2F);
  static const Color lightOrangeColor = Color.fromARGB(255, 255, 203, 126);
  static const Color darkOrangeColor = Color.fromARGB(255, 255, 156, 8);
  static const Color darkBlueColor = Color.fromARGB(255, 0, 64, 99);
  static const Color blueColor = Color(0xff0077B5);
  static const Color lightBlueColor = Color(0x8A0076B5);
  static const Color redColor = Color.fromARGB(255, 255, 91, 80);
  static const Color whiteColor = Colors.white;

  // NEW COLORS for Redesign (Based on functional use)
  static const Color primaryDark =
      Color(0xFF343A40); // Used for main CTA/Log New Entry button
  static const Color successTeal = Color(
      0xFF3B9C9B); // Accent Positive: Income, Credit, Savings Goal Progress
  static const Color warningOrange =
      Color(0xFFFF7F50); // Accent Negative: Expenses, Debts, Warnings
  static const Color darkText =
      Color(0xFF333333); // Standard body text and header text
  static const Color dividerLight =
      Color(0xFFEBEBEB); // Subtle lines for separating transactions
  static const Color accentBlueSubtle =
      Color(0xFF5F9EA0); // Secondary accent, like the goal percentage
}
