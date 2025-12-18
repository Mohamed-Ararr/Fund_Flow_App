import 'package:flutter/material.dart';
import 'package:fundflow/Features/InsightsFeature/widgets/MonthSummary.dart';

import '../../Core/AppColors.dart';
import 'widgets/CategoriesBreakdown.dart';
import 'widgets/DebtsCreditsSummary.dart';
import 'widgets/SpendingTrends.dart';

class InsightsView extends StatelessWidget {
  const InsightsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Insights',
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Beta',
                    style: TextStyle(
                      color: AppColors.blueColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const MonthSummary(),
            const SizedBox(height: 20),
            const SpendingTrendsSection(),
            const SizedBox(height: 20),
            const CategoriesBreakdownSection(),
            const SizedBox(height: 20),
            const DebtCreditsSummary(),
          ],
        ),
      ),
    );
  }
}
