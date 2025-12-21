import 'package:flutter/material.dart';
import 'package:fundflow/Core/helper.dart';

import '../../../../ContValues.dart';
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

  @override
  Widget build(BuildContext context) {
    // Format the amount string (e.g., adds '$' and keeps two decimal places)
    final String formattedAmount =
        '${amount >= 0 ? '+' : '-'}${getCurrencySymbol()} ${amount.abs().toStringAsFixed(2)}';
    final color = Theme.of(context).colorScheme;
    final theme = Theme.of(context).textTheme;
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
                color: color.primary
                    .withValues(alpha: 0.1), // Light background tint
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Helper.getCategoryIcon(subtitle),
                color: color.primary, // Icon color matches the amount type
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
              style: theme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 19,
                color: color.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
