import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/ContValues.dart';

import '../../../../Core/AppColors.dart';
import '../../../../Core/AppTextStyles.dart';

class DebtsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double amount;
  final IconData icon; // e.g., FontAwesomeIcons.utensils
  final VoidCallback onTap;

  const DebtsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.onTap,
  });

  // Determines the color and text style based on the amount's sign
  TextStyle _amountTextStyle(BuildContext context) {
    return amount >= 0
        ? AppTextStyles.amountPositive(context)
        : AppTextStyles.amountNegative(context);
  }

  // Determines the icon background color
  Color get _iconColor {
    return amount >= 0 ? AppColors.successTeal : AppColors.warningOrange;
  }

  // Determines the icon
  IconData get _icon {
    return amount >= 0 ? FontAwesomeIcons.arrowDown : FontAwesomeIcons.arrowUp;
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
                _icon,
                color: _iconColor, // Icon color matches the amount type
                size: 20.0,
              ),
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
                    style: AppTextStyles.listItemTitle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: AppTextStyles.listItemSubtitle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // 3. Amount (Dynamic Style)
            Text(
              formattedAmount,
              style: _amountTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }
}
