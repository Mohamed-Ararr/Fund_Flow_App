import 'package:flutter/material.dart';
import 'package:fundflow/Core/buttons.dart';

import '../../../../Core/AppTextStyles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Consistent horizontal padding with the dashboard
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Section Title
          Text(
            title,
            style: AppTextStyles.headerSectionTitle,
          ),

          // 2. Action Button (e.g., "View All" or "Manage")
          AppButton.text(
            context,
            onPressed: onActionTap,
            text: actionText,
          ),
        ],
      ),
    );
  }
}
