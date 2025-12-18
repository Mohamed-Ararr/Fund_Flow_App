import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';

import '../../../Core/AppColors.dart';
import '../../../Core/helper.dart';
import '../../../Data/BLoC Manager/Transaction Cubit/transaction_cubit.dart';

class CategoriesBreakdownSection extends StatelessWidget {
  const CategoriesBreakdownSection({super.key});

  Color categoryColor(String ctg) {
    switch (ctg) {
      case 'Housing & Utilities':
        return AppColors.orangeColor;
      case 'Food & Groceries':
        return AppColors.blueColor;
      case 'Transportation':
        return AppColors.successTeal;
      case 'Others':
        return AppColors.darkText;
      case 'Personal & Miscellaneous':
        return AppColors.redColor;
      default:
        return AppColors.greyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TransactionLoaded) {
          final stats = Helper.calculateCategoryBreakdown(state.transactions);

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
                  'Categories Breakdown',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 16),
                ...stats.map(
                  (item) => _CategoryItem(
                    name: item.category,
                    amount:
                        '${getCurrencySymbol()} ${item.total.toStringAsFixed(2)}',
                    percentage:
                        '${(item.percentage * 100).toStringAsFixed(1)}%',
                    progress: item.percentage,
                    color: categoryColor(item.category),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
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
