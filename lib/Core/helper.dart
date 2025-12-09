import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
}
