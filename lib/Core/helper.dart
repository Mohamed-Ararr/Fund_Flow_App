class Helper {
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
}
