import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Data/BLoC%20Manager/Transaction%20Cubit/transaction_cubit.dart';

import '../../../Core/AppColors.dart';
import '../../../Data/Models/TransactionModel/TransactionModel.dart';

class SpendingTrendsSection extends StatefulWidget {
  const SpendingTrendsSection({super.key});

  @override
  State<SpendingTrendsSection> createState() => _SpendingTrendsSectionState();
}

class _SpendingTrendsSectionState extends State<SpendingTrendsSection> {
  String selectedTab = 'Daily'; // Default selected tab

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        List<TransactionModel> transactions = [];
        if (state is TransactionLoaded) {
          transactions = state.transactions;
        }

        // Prepare chart data
        final chartMap = _prepareChartData(transactions, selectedTab);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.lightGreyColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Spending Trends',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.lightGreyColor),
                ),
                child: Row(
                  children: ['Daily', 'Weekly', 'Monthly'].map((tab) {
                    final isSelected = tab == selectedTab;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedTab = tab),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.blueColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tab,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.greyColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
              // Custom Bar Chart
              Container(
                height: 210,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _CustomBarChart(
                  data: chartMap['data']!.cast<double>(),
                  labels: chartMap['labels']!.cast<String>(),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.orangeColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(getCurrencySymbol()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper to prepare chart data based on tab
  Map<String, List<dynamic>> _prepareChartData(
      List<TransactionModel> transactions, String selectedTab) {
    List<double> data = [];
    List<String> labels = [];

    if (selectedTab == 'Daily') {
      final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      for (var day in days) {
        final total = transactions
            .where((tx) => _getWeekday(tx.date) == day)
            .fold<double>(0, (sum, tx) => sum + (tx.spentAmount ?? 0.0));
        data.add(total.toDouble().abs());
        labels.add(day);
      }
    } else if (selectedTab == 'Weekly') {
      for (int i = 1; i <= 5; i++) {
        final total = transactions
            .where((tx) => _getWeekOfMonth(tx.date) == i)
            .fold<double>(0, (sum, tx) => sum + (tx.spentAmount ?? 0.0));
        data.add(total.toDouble().abs());
        labels.add('W$i');
      }
    } else if (selectedTab == 'Monthly') {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      for (int i = 1; i <= 12; i++) {
        final total = transactions
            .where((tx) => _getMonth(tx.date) == i)
            .fold<double>(0, (sum, tx) => sum + (tx.spentAmount ?? 0.0));
        data.add(total.toDouble().abs());
        labels.add(months[i - 1]);
      }
    }

    return {'data': data, 'labels': labels};
  }

  // Helpers to parse date
  String _getWeekday(String? dateStr) {
    if (dateStr == null) return '';
    final parts = dateStr.split('/'); // dd/mm/yyyy
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    final date = DateTime(year, month, day);
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
  }

  int _getWeekOfMonth(String? dateStr) {
    if (dateStr == null) return 0;
    final parts = dateStr.split('/');
    final day = int.parse(parts[0]);
    return ((day - 1) ~/ 7) + 1; // Week 1, 2, ...
  }

  int _getMonth(String? dateStr) {
    if (dateStr == null) return 0;
    final parts = dateStr.split('/');
    return int.parse(parts[1]);
  }
}

class _CustomBarChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;

  const _CustomBarChart({required this.data, required this.labels});

  @override
  Widget build(BuildContext context) {
    final isScrollable = labels.length > 7;

    // Maximum height for a bar
    const double maxBarHeight = 125;

    // Find the maximum value in data to scale bars
    final maxValue =
        data.isNotEmpty ? data.reduce((a, b) => a > b ? a : b) : 1.0;

    final chartBars = List.generate(data.length, (index) {
      // Scale the bar height, but don't exceed maxBarHeight
      final double barHeight =
          maxValue > 0 ? (data[index] / maxValue) * maxBarHeight : 0;

      // Format amount (e.g., 1.2k)
      String formatAmount(double amount) {
        if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(2)}k';
        return amount.toStringAsFixed(0);
      }

      final amountText = formatAmount(data[index]);

      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Amount on top of bar
          Text(
            amountText,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 4),
          // Bar
          Container(
            width: 28,
            height: barHeight,
            decoration: BoxDecoration(
              color: AppColors.orangeColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          // Label under bar
          Text(
            labels[index],
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 4),
          // Small dot indicator under each bar
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.orangeColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      );
    });

    return isScrollable
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: chartBars
                  .map((bar) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: bar,
                      ))
                  .toList(),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: chartBars,
          );
  }
}
