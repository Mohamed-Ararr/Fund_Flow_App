import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/Features/InsightsFeature/widgets/MonthSummary.dart';

import 'widgets/CategoriesBreakdown.dart';
import 'widgets/DebtsCreditsSummary.dart';
import 'widgets/SpendingTrends.dart';

class InsightsView extends StatelessWidget {
  const InsightsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'insights'.tr(),
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Beta',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
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
