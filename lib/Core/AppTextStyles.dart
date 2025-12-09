import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppTextStyles {
  // 1. PRIMARY FOCAL POINT (The Current Balance)
  static const TextStyle focalPointBalance = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.w800, // Extra Bold
    color: AppColors.darkText,
    letterSpacing: -1.0,
  );

  // 2. HEADERS & TITLES
  static const TextStyle headerSectionTitle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.darkText,
    letterSpacing: 0.1,
  );

  static const TextStyle buttonPrimary = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600, // Semi-Bold
    color: AppColors.whiteColor,
  );

  // 3. TRANSACTION & LIST ITEM STYLES
  // Used for transaction titles (e.g., "Dinner at Olive Garden")
  static const TextStyle listItemTitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.darkText,
  );

  // Used for sub-details (e.g., "Today, 7:30 PM", "Due in 5 days")
  static const TextStyle listItemSubtitle = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.greyColor,
  );

  // 4. TRANSACTION AMOUNT STYLES (Dynamic based on +/-)
  // For positive transactions (Income, Credit)
  static const TextStyle amountPositive = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600, // Semi-Bold
    color: AppColors.successTeal,
  );

  // For negative transactions (Expense, Debt Payment)
  static const TextStyle amountNegative = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.warningOrange,
  );

  // 5. SMALLER UI TEXT
  // Used for Currency code (USD), "View All", and progress percentage
  static const TextStyle uiDetails = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.greyColor,
  );

  // 6. SAVINGS GOAL SPECIFIC
  // Used for the percentage display (e.g., "68%")
  static const TextStyle goalPercentage = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
  );

  // Used for the amount saved (e.g., "$816 saved")
  static const TextStyle goalSubAmount = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.greyColor,
  );

  // Used for the remaining amount text (e.g., "$384 remaining")
  static const TextStyle goalRemaining = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColors.darkText, // Darker text for more prominence above the bar
  );

  // Used for the target amount text (e.g., "$1,200 goal")
  static const TextStyle goalTarget = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.greyColor,
  );
}
