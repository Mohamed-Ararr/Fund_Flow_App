import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';

import '../../../Core/AppColors.dart';
import '../../../Data/BLoC Manager/Transaction Cubit/transaction_cubit.dart';
import '../../../Data/Models/CategoryStatus.dart';
import '../../../Data/Models/TransactionModel/TransactionModel.dart';

class CategoriesBreakdownSection extends StatelessWidget {
  const CategoriesBreakdownSection({super.key});

  // Define category keys
  static const List<String> _categoryKeys = [
    'housing',
    'foodGroceries',
    'transportation',
    'personalMiscellaneous',
    'others',
  ];

  // Map translation keys to colors
  static const Map<String, Color> _categoryColors = {
    "housing": AppColors.blueColor,
    "foodGroceries": Colors.grey,
    "transportation": AppColors.lightOrangeColor,
    "personalMiscellaneous": AppColors.warningOrange,
    "others": AppColors.darkText,
  };

  /// Normalize any category descriptor to its key
  String _normalizeCategoryToKey(String? categoryDesc) {
    if (categoryDesc == null || categoryDesc.isEmpty) {
      return 'others';
    }

    final Map<String, String> reverseMap = {
      // English
      "Housing & Utilities": "housing",
      "Food & Groceries": "foodGroceries",
      "Transportation": "transportation",
      "Personal & Miscellaneous": "personalMiscellaneous",
      "Others": "others",

      // French
      "Logement et Services": "housing",
      "Alimentation et Épicerie": "foodGroceries",
      "Transport": "transportation",
      "Personnel et Divers": "personalMiscellaneous",
      "Autres": "others",

      // Arabic
      "السكن والمرافق": "housing",
      "الطعام والبقالة": "foodGroceries",
      "المواصلات": "transportation",
      "شخصي ومتنوع": "personalMiscellaneous",
      "أخرى": "others",

      // Keys (already normalized)
      "housing": "housing",
      "foodGroceries": "foodGroceries",
      "transportation": "transportation",
      "personalMiscellaneous": "personalMiscellaneous",
      "others": "others",
    };

    // Try exact match
    String? key = reverseMap[categoryDesc];

    // Try case-insensitive
    key ??= reverseMap[categoryDesc.toLowerCase()];

    // Try trimmed
    key ??= reverseMap[categoryDesc.trim()];

    return key ?? 'others';
  }

  /// Calculate category breakdown from transactions
  List<CategoryStats> _calculateCategoryBreakdown(
    List<TransactionModel> transactions,
  ) {
    // 1. Initialize all categories with 0
    final Map<String, double> totals = {
      for (final ctg in _categoryKeys) ctg: 0.0,
    };

    // 2. Sum transactions into predefined categories
    for (final tx in transactions) {
      final rawCategory = tx.desc; // Raw value from database
      final amount = tx.spentAmount ?? 0;

      // Normalize the category to key before comparing
      final normalizedKey = _normalizeCategoryToKey(rawCategory);

      if (totals.containsKey(normalizedKey)) {
        totals[normalizedKey] = totals[normalizedKey]! + amount;
      }
    }

    // 3. Calculate grand total
    final double grandTotal =
        totals.values.fold(0.0, (sum, value) => sum + value);

    // 4. Build stats (never empty, percentages safe)
    return _categoryKeys.map((ctg) {
      final total = totals[ctg]!;
      final percentage = grandTotal == 0 ? 0.0 : total / grandTotal;

      return CategoryStats(
        category: ctg,
        total: total,
        percentage: percentage.abs(),
      );
    }).toList();
  }

  /// Get color for a category key
  Color _categoryColor(String categoryKey) {
    return _categoryColors[categoryKey] ?? AppColors.greyColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TransactionLoaded) {
          final stats = _calculateCategoryBreakdown(state.transactions);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'categoriesBreakdown'.tr(),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              ...stats.map(
                (item) => _CategoryItem(
                  name: item.category.tr(), // Translate the key
                  amount:
                      '${getCurrencySymbol()} ${item.total.toStringAsFixed(2)}',
                  percentage: '${(item.percentage * 100).toStringAsFixed(1)}%',
                  progress: item.percentage,
                  color: _categoryColor(item.category), // Use key directly
                ),
              ),
            ],
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
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
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
                style: theme.textTheme.bodyMedium,
              ),
              const Spacer(),
              Text(
                percentage,
                style: theme.textTheme.bodyMedium,
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
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
