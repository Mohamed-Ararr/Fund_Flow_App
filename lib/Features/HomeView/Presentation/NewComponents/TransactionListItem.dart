import 'package:flutter/material.dart';
import 'package:fundflow/Core/helper.dart';

import '../../../../ContValues.dart';
import '../../../../Core/AppColors.dart';
import '../../../../Core/AppTextStyles.dart';

class TransactionListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final double amount;
  final IconData icon; // e.g., FontAwesomeIcons.utensils
  final VoidCallback onTap;

  const TransactionListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.onTap,
  });

  // Determines the icon background color
  Color get _iconColor {
    return AppColors.darkBlueColor;
    // return amount >= 0 ? AppColors.successTeal : AppColors.warningOrange;
  }

  @override
  Widget build(BuildContext context) {
    // Format the amount string (e.g., adds '$' and keeps two decimal places)
    final String formattedAmount =
        '${amount >= 0 ? '+' : '-'}${getCurrencySymbol()} ${amount.abs().toStringAsFixed(2)}';

    return InkWell(
      onTap: onTap,
      child: Padding(
        // Add horizontal padding to align with the SectionHeader
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Icon Container (Dynamic Color)
            Container(
              width: 44, // Fixed width
              height: 44, // Fixed height
              decoration: BoxDecoration(
                color:
                    _iconColor.withValues(alpha: 0.1), // Light background tint
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Helper.getCategoryIcon(subtitle),
                color: _iconColor, // Icon color matches the amount type
                size: 20.0,
              ),
              // Displaying first letter of the title
              // child: Center(
              //   child: Text(
              //     title.split('').first.toUpperCase(),
              //     style: AppTextStyles.headerSectionTitle,
              //   ),
              // ),
            ),

            const SizedBox(width: 12.0),

            // 2. Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.listItemTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: AppTextStyles.listItemSubtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // 3. Amount (Dynamic Style)
            Text(
              formattedAmount,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
