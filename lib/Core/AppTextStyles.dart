import 'package:flutter/material.dart';

class AppTextStyles {
  // 1. PRIMARY FOCAL POINT (Balance)
  static TextStyle focalPointBalance(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          );

  // 2. HEADERS & TITLES
  static TextStyle headerSectionTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          );

  static TextStyle buttonPrimary(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimary,
          );

  // 3. LIST ITEMS
  static TextStyle listItemTitle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          );

  static TextStyle listItemSubtitle(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          );

  // 4. AMOUNTS
  static TextStyle amountPositive(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          );

  static TextStyle amountNegative(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.error,
          );

  // 5. SMALL UI TEXT
  static TextStyle uiDetails(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall!.copyWith(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          );

  // 6. SAVINGS GOALS
  static TextStyle goalPercentage(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          );

  static TextStyle goalSubAmount(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall!.copyWith(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          );

  static TextStyle goalRemaining(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          );

  static TextStyle goalTarget(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall!.copyWith(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          );
}
