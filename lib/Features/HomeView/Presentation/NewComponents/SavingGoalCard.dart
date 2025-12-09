import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Core/AppColors.dart';
import '../../../../Core/AppTextStyles.dart';

class SavingsGoalCard extends StatelessWidget {
  final String goalName;
  final double currentAmount;
  final double targetAmount;
  final IconData icon; // e.g., FontAwesomeIcons.laptop
  final VoidCallback onTap;

  const SavingsGoalCard({
    super.key,
    required this.goalName,
    required this.currentAmount,
    required this.targetAmount,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Calculate Progress Values
    final double progress = currentAmount / targetAmount;
    final double remainingAmount = targetAmount - currentAmount;
    final int percentage = (progress * 100).toInt().clamp(0, 100);

    // 2. Format Currency
    // Note: Assuming a helper for formatting currency is available in the real app.
    final String formattedRemaining =
        '\$${remainingAmount.toStringAsFixed(0)} remaining';
    final String formattedTarget = '\$${targetAmount.toStringAsFixed(0)} goal';
    final String formattedSaved = '\$${currentAmount.toStringAsFixed(0)} saved';

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.successTeal.withOpacity(0.2),
              AppColors.successTeal.withOpacity(0.1),
            ],
          ),
          // Background color for the card itself, matching the design's light green/teal tint
          // color: AppColors.successTeal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row 1: Icon, Title, Percentage, and Saved Amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Container
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors
                        .successTeal, // Solid color for the icon background
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: FaIcon(
                      icon,
                      color: AppColors.whiteColor, // White icon
                      size: 20.0,
                    ),
                  ),
                ),

                const SizedBox(width: 12.0),

                // Title and Goal Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goalName,
                        style: AppTextStyles.listItemTitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        formattedTarget,
                        style: AppTextStyles.goalTarget,
                      ),
                    ],
                  ),
                ),

                // Percentage and Saved Amount (Right Aligned)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$percentage%',
                      style: AppTextStyles.goalPercentage.copyWith(
                        color: AppColors.successTeal,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      formattedSaved,
                      style: AppTextStyles.goalSubAmount,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Row 2: Remaining Amount and Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Linear Progress Bar with Rounded Ends
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 12.0, // Height of the bar
                    backgroundColor: AppColors
                        .whiteColor, // The lighter, empty part of the bar
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.successTeal,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                // Remaining amount text above the bar
                Text(
                  formattedRemaining,
                  style: AppTextStyles.goalRemaining.copyWith(
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
