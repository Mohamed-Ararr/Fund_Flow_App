import 'package:hive/hive.dart';

// IMPORTANT: Run 'flutter pub run build_runner build' after creating this file.
// Choose a unique typeId (e.g., 1) for this model.
part 'BalanceEntryModel.g.dart';

@HiveType(typeId: 10)
class BalanceEntryModel extends HiveObject {
  @HiveField(0)
  final double amount; // The transaction amount (can be positive or negative)

  @HiveField(1)
  final String date; // The date of the transaction

  @HiveField(2)
  final String title; // Add title for context in charts/logs

  BalanceEntryModel({
    required this.amount,
    required this.date,
    required this.title,
  });

  @override
  String toString() {
    return 'BalanceEntry(title: $title, amount: $amount, date: $date)';
  }
}
