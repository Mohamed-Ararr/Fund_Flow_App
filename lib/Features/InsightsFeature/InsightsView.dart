// ---------------------------------------------------------------------------
// MAIN SCREEN
// ---------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:fundflow/Features/InsightsFeature/widgets/MonthSummary.dart';

import '../../Core/AppColors.dart';

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
            const _SpendingTrendsSection(),
            const SizedBox(height: 20),
            const _CategoriesBreakdownSection(),
            const SizedBox(height: 20),
            const _BottomDetailSection(),
            const SizedBox(height: 30), // Bottom padding
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1: THIS MONTH SUMMARY (GRID)
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// SECTION 2: SPENDING TRENDS (CHART)
// ---------------------------------------------------------------------------
class _SpendingTrendsSection extends StatelessWidget {
  const _SpendingTrendsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 80, // Constrain width for wrapping
                child: Text(
                  'Spending Trends',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                    height: 1.1,
                  ),
                ),
              ),
              // Segment Control Mockup
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.lightGreyColor),
                ),
                child: Row(
                  children: [
                    _buildTab('Daily', true),
                    _buildTab('Weekly', false),
                    _buildTab('Monthly', false),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          // Custom Bar Chart
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const _CustomBarChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blueColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : AppColors.greyColor,
        ),
      ),
    );
  }
}

class _CustomBarChart extends StatelessWidget {
  const _CustomBarChart();

  @override
  Widget build(BuildContext context) {
    final data = [0.4, 0.3, 0.55, 0.7, 0.6, 0.8, 0.5]; // Normalized 0.0 to 1.0
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(data.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 28, // Bar width
                height: constraints.maxHeight * 0.8 * data[index],
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                labels[index],
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}

// ---------------------------------------------------------------------------
// SECTION 3: CATEGORIES BREAKDOWN
// ---------------------------------------------------------------------------
class _CategoriesBreakdownSection extends StatelessWidget {
  const _CategoriesBreakdownSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 16),
          _CategoryItem(
            name: 'Food & Dining',
            amount: '\$996',
            percentage: '35%',
            progress: 0.35,
            color: AppColors.orangeColor,
          ),
          _CategoryItem(
            name: 'Transportation',
            amount: '\$797',
            percentage: '28%',
            progress: 0.28,
            color: AppColors.blueColor,
          ),
          _CategoryItem(
            name: 'Shopping',
            amount: '\$626',
            percentage: '22%',
            progress: 0.22,
            color: AppColors.successTeal, // Screenshot looks teal-ish
          ),
          _CategoryItem(
            name: 'Entertainment',
            amount: '\$427',
            percentage: '15%',
            progress: 0.15,
            color: AppColors.redColor,
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String name;
  final String amount;
  final String percentage;
  final double progress;
  final Color color;

  const _CategoryItem({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
              ),
              const Spacer(),
              Text(
                percentage,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.lightGreyColor,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              amount,
              style: const TextStyle(
                color: AppColors.greyColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4: BOTTOM DETAIL SECTION (CREDITS & DEBTS)
// ---------------------------------------------------------------------------
class _BottomDetailSection extends StatelessWidget {
  const _BottomDetailSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DetailSummaryCard(
            title: 'Credits',
            totalAmount: '\$4,200',
            items: const [
              MapEntry('Salary', '\$3,800'),
              MapEntry('Freelance', '\$400'),
            ],
            mainColor: AppColors.successTeal,
            icon: Icons.arrow_upward,
            progressLabel: '85% of target',
            progressValue: 0.85,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _DetailSummaryCard(
            title: 'Debts',
            totalAmount: '\$1,240',
            items: const [
              MapEntry('Credit Card', '\$890'),
              MapEntry('Loan', '\$350'),
            ],
            mainColor: AppColors.redColor, // Using red for Debt warning
            icon: Icons.arrow_downward,
            progressLabel: '62% of limit',
            progressValue: 0.62,
          ),
        ),
      ],
    );
  }
}

class _DetailSummaryCard extends StatelessWidget {
  final String title;
  final String totalAmount;
  final List<MapEntry<String, String>> items;
  final Color mainColor;
  final IconData icon;
  final String progressLabel;
  final double progressValue;

  const _DetailSummaryCard({
    required this.title,
    required this.totalAmount,
    required this.items,
    required this.mainColor,
    required this.icon,
    required this.progressLabel,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: mainColor),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            totalAmount,
            style: TextStyle(
              color: mainColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // List Items
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.key,
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      item.value,
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor:
                  AppColors.lightGreyColor.withOpacity(0.5), // Darker bg
              valueColor: AlwaysStoppedAnimation<Color>(mainColor),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            progressLabel,
            style: const TextStyle(
              color: AppColors.greyColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
