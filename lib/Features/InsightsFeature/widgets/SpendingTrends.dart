import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Core/AppTextStyles.dart';
import 'package:fundflow/Data/BLoC%20Manager/Transaction%20Cubit/transaction_cubit.dart';

import '../../../Core/AppColors.dart';
import '../../../Core/helper.dart';
import '../../../Core/popup.dart';
import '../../../Data/Models/TransactionModel/TransactionModel.dart';
import '../../HomeView/Presentation/NewComponents/TransactionListItem.dart';

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

        final theme = Theme.of(context);
        // Prepare chart data
        final chartMap = _prepareChartData(transactions, selectedTab);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending Trends',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: ['Daily', 'Weekly', 'Monthly'].map((tab) {
                  final isSelected = tab == selectedTab;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = tab),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tab,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.uiDetails(context).copyWith(
                            color: !isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.surface,
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
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _CustomBarChart(
                barType: selectedTab,
                allTransactions: transactions,
                data: chartMap['data']!.cast<double>(),
                labels: chartMap['labels']!.cast<String>(),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(getCurrencySymbol()),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper to prepare chart data based on tab
  Map<String, List<dynamic>> _prepareChartData(
      List<TransactionModel> transactions, String selectedTab) {
    final now = DateTime.now();

    List<double> data = [];
    List<String> labels = [];

    if (selectedTab == 'Daily') {
      /// LAST 7 DAYS
      for (int i = 6; i >= 0; i--) {
        final date = now.subtract(Duration(days: i));
        final formatted = "${date.day}/${date.month}/${date.year}";

        final total = transactions
            .where((tx) => tx.date == formatted)
            .fold<double>(0, (sum, tx) => sum + ((tx.spentAmount ?? 0) * -1));

        data.add(total);
        labels.add(Helper.weekdayShort(date.weekday)); // Mon, Tue, ...
      }
    } else if (selectedTab == 'Weekly') {
      // Determine the current date
      final DateTime now = DateTime.now();

      // Determine the start of the week (Monday)
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

      // Generate 5 weeks back including current one
      for (int i = 0; i < 5; i++) {
        final DateTime weekStart = startOfWeek.subtract(Duration(days: 7 * i));
        final DateTime weekEnd = weekStart.add(const Duration(days: 6));

        // Filter transactions in this date range
        final total = transactions.where((tx) {
          if (tx.date == null) return false;

          final parts = tx.date!.split('/'); // dd/mm/yyyy
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);

          final dt = DateTime(year, month, day);

          return dt.isAfter(weekStart.subtract(const Duration(days: 1))) &&
              dt.isBefore(weekEnd.add(const Duration(days: 1)));
        }).fold<double>(0, (sum, tx) => sum + (tx.spentAmount ?? 0.0));

        // Add total
        data.add(total.toDouble().abs());

        // Create label like "Jan 1–7"
        labels.add(
            "${Helper.monthShort(weekStart.month)} ${weekStart.day}–${weekEnd.day}");
      }

      // Reverse so oldest week is left-most, current week right-most
      data = data.reversed.toList();
      labels = labels.reversed.toList();
    } else if (selectedTab == 'Monthly') {
      /// LAST 12 MONTHS
      for (int i = 11; i >= 0; i--) {
        final date = DateTime(now.year, now.month - i, 1);

        final total = transactions.where((tx) {
          final d = Helper.parse(tx.date ?? DateTime.now().toString());
          return d.year == date.year && d.month == date.month;
        }).fold<double>(0, (sum, tx) => sum + ((tx.spentAmount ?? 0) * -1));

        data.add(total);
        labels.add(Helper.monthShort(date.month)); // Jan, Feb…
      }
    }

    return {"data": data, "labels": labels};
  }
}

class _CustomBarChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final List<TransactionModel> allTransactions;
  final String barType;

  const _CustomBarChart(
      {required this.data,
      required this.labels,
      required this.allTransactions,
      required this.barType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            style: theme.textTheme.labelSmall,
          ),
          const SizedBox(height: 4),
          // Bar
          InkWell(
            onTap: () {
              final filteredTransactions = _filterTransactions(
                index,
                barType,
              );
              _showDetails(context, labels[index], filteredTransactions);
            },
            child: Container(
              width: 28,
              height: barHeight,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Label under bar
          Text(
            labels[index],
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 4),
          // Small dot indicator under each bar
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
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

  /// FILTER TRANSACTIONS BASED ON BAR
  List<TransactionModel> _filterTransactions(int index, String barType) {
    final now = DateTime.now();

    if (barType == 'Daily') {
      final date = now.subtract(Duration(days: data.length - 1 - index));
      return allTransactions.where((tx) {
        if (tx.date == null) return false;
        final parts = tx.date!.split('/'); // dd/MM/yyyy
        final txDate = DateTime(
            int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        return txDate.year == date.year &&
            txDate.month == date.month &&
            txDate.day == date.day;
      }).toList();
    } else if (barType == 'Weekly') {
      final startOfWeek = now.subtract(
          Duration(days: now.weekday - 1 + (data.length - 1 - index) * 7));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));

      return allTransactions.where((tx) {
        if (tx.date == null) return false;
        final parts = tx.date!.split('/');
        final txDate = DateTime(
            int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        return !txDate.isBefore(startOfWeek) && !txDate.isAfter(endOfWeek);
      }).toList();
    } else if (barType == 'Monthly') {
      final monthDate =
          DateTime(now.year, now.month - (data.length - 1 - index), 1);
      return allTransactions.where((tx) {
        if (tx.date == null) return false;
        final parts = tx.date!.split('/');
        final txDate = DateTime(
            int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        return txDate.year == monthDate.year && txDate.month == monthDate.month;
      }).toList();
    }

    return [];
  }

  /// BOTTOM SHEET
  void _showDetails(
    BuildContext context,
    String label,
    List<TransactionModel> txs,
  ) {
    Popup.showBottom(
      context,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Spending • $label",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 12),
            if (txs.isEmpty)
              const Center(child: Text("No spendings"))
            else
              ListView.separated(
                shrinkWrap: true,
                itemCount: txs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 1),
                itemBuilder: (_, i) {
                  final tx = txs[i];
                  return TransactionListItem(
                    title: tx.title ?? "Unknown",
                    subtitle: tx.desc!,
                    amount: tx.spentAmount!,
                    icon: Icons.attach_money,
                    onTap: () {},
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget transactionCard(TransactionModel tx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor, // subtle background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Category / icon circle
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.orangeColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.attach_money, // You can choose icon based on category
                color: AppColors.orangeColor,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Title + description/date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title ?? "Unknown",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${tx.desc ?? tx.desc} • ${tx.date}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            "${getCurrencySymbol()} ${(tx.spentAmount ?? 0).abs().toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: (tx.spentAmount ?? 0) >= 0
                  ? AppColors.successTeal
                  : AppColors.redColor,
            ),
          ),
        ],
      ),
    );
  }
}
