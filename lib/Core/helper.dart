import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/Data/Models/Debt%20Card%20Model/DebtCardModel.dart';

import '../ContValues.dart';
import '../Data/Models/CategoryStatus.dart';
import '../Data/Models/TransactionModel/TransactionModel.dart';

class Helper {
  static double width(context) => MediaQuery.sizeOf(context).width;
  static String formatCurrency(double? value) {
    if (value == null) {
      return "0.00";
    }
    final number = value.toStringAsFixed(2);
    final parts = number.split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    final buffer = StringBuffer();
    for (int i = 0; i < integerPart.length; i++) {
      final reverseIndex = integerPart.length - 1 - i;
      buffer.write(integerPart[reverseIndex]);

      if ((i + 1) % 3 == 0 && i + 1 != integerPart.length) {
        buffer.write(' ');
      }
    }

    final formattedInteger = buffer.toString().split('').reversed.join();

    return "$formattedInteger.$decimalPart";
  }

  static // A helper function to apply the LTR override for bidi issues
      String formatCurrencyWithBidi(String value, String symbol) {
    // Use LRE (\u202A) to force Left-to-Right Embedding and PDF (\u202C) to close it.
    // This ensures the visual order is exactly as defined in the string: VALUE SYMBOL

    // Logical order: Value (e.g., "100.00") Space Symbol (e.g., " دج")
    final String combinedString = '$value $symbol';

    // Return the combined string wrapped in LTR markers
    return '\u202A$combinedString\u202C';
  }

  static IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Housing & Utilities':
        // Solid building/shelter icon
        return FontAwesomeIcons.houseChimney;

      case 'Food & Groceries':
        // Solid shopping cart for groceries/food
        return FontAwesomeIcons.cartShopping;

      case 'Transportation':
        // Solid car icon for travel expenses
        return FontAwesomeIcons.car;

      case 'Income (Salary, Side-Gigs)':
        // Solid money/trend icon indicating income
        return FontAwesomeIcons.moneyBillTrendUp;

      case 'Personal & Miscellaneous':
        // Solid shopping bag for general personal purchases/misc items
        return FontAwesomeIcons.bagShopping;

      default:
        // Fallback solid question mark
        return FontAwesomeIcons.question;
    }
  }

  static totalTransaction(List<TransactionModel>? transactions) {
    if (transactions == null || transactions.isEmpty) {
      return '-${getCurrencySymbol()} 0';
    }
    double total = 0.0;
    for (var transaction in transactions) {
      total += transaction.spentAmount ?? 0.0;
    }
    final String formattedAmount =
        '-${getCurrencySymbol()} ${total.abs().toStringAsFixed(2)}';
    return formattedAmount;
  }

  static totalDebts(List<DebtCardModel>? debts) {
    if (debts == null || debts.isEmpty) {
      return '-${getCurrencySymbol()} 0';
    }
    double total = 0.0;
    for (var debt in debts) {
      if (debt.isDebt) {
        total += debt.amount;
      }
    }
    final String formattedAmount =
        '-${getCurrencySymbol()} ${total.abs().toStringAsFixed(2)}';
    return formattedAmount;
  }

  static totalCredits(List<DebtCardModel>? credits) {
    if (credits == null || credits.isEmpty) {
      return '${getCurrencySymbol()} 0';
    }
    double total = 0.0;
    for (var credit in credits) {
      if (!credit.isDebt) {
        total += credit.amount;
      }
    }
    final String formattedAmount =
        '${getCurrencySymbol()} ${total.abs().toStringAsFixed(2)}';
    return formattedAmount;
  }

  static DateTime parse(String dateStr) {
    final parts = dateStr.split('/'); // dd/mm/yyyy
    return DateTime(
        int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }

  static String weekdayShort(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  static String monthShort(int month) {
    const months = [
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
    return months[month - 1];
  }

  static List<CategoryStats> calculateCategoryBreakdown(
    List<TransactionModel> transactions,
  ) {
    // 1. Initialize all categories with 0
    final Map<String, double> totals = {
      for (final ctg in categories) ctg: 0.0,
    };

    // 2. Sum transactions into predefined categories
    for (final tx in transactions) {
      final category = tx.desc; // or tx.category later
      final amount = tx.spentAmount ?? 0;

      if (category != null && totals.containsKey(category)) {
        totals[category] = totals[category]! + amount;
      }
    }

    // 3. Calculate grand total
    final double grandTotal =
        totals.values.fold(0.0, (sum, value) => sum + value);

    // 4. Build stats (never empty, percentages safe)
    return categories.map((ctg) {
      final total = totals[ctg]!;
      final percentage = grandTotal == 0 ? 0.0 : total / grandTotal;

      return CategoryStats(
        category: ctg,
        total: total,
        percentage: percentage.abs(),
      );
    }).toList();
  }

  static String compactCurrencyString(String rawAmount) {
    if (rawAmount.trim().isEmpty) return rawAmount;

    final trimmed = rawAmount.trim();

    // 1️⃣ Extract number (with optional minus)
    final numberMatch = RegExp(r'-?\d+(\.\d+)?').firstMatch(trimmed);
    if (numberMatch == null) return rawAmount;

    final value = double.tryParse(numberMatch.group(0)!);
    if (value == null) return rawAmount;

    // 2️⃣ Extract prefix & suffix (currency position)
    final start = numberMatch.start;
    final end = numberMatch.end;

    final prefix = trimmed.substring(0, start).trim();
    final suffix = trimmed.substring(end).trim();

    // 3️⃣ Compact number
    final absValue = value.abs();
    String compact;

    if (absValue >= 1e9) {
      compact = '${(absValue / 1e9).toStringAsFixed(2)} B';
    } else if (absValue >= 1e6) {
      compact = '${(absValue / 1e6).toStringAsFixed(2)} M';
    } else if (absValue >= 1e3) {
      compact = '${(absValue / 1e3).toStringAsFixed(2)} K';
    } else {
      compact = absValue.toStringAsFixed(2);
    }

    final sign = value < 0 ? '-' : '';

    // 4️⃣ Rebuild string (currency stays in original place)
    if (suffix.isNotEmpty) {
      // number FIRST → currency after
      return '$sign$compact $suffix';
    } else {
      // currency FIRST → number after
      return '$sign$prefix$compact';
    }
  }
  // compact = "${absValue.toStringAsFixed(2)} ${getCurrencySymbol()}";
}
