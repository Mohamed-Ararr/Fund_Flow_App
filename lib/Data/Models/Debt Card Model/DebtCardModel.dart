import 'package:hive_flutter/hive_flutter.dart';

part "DebtCardModel.g.dart";

@HiveType(typeId: 2)
class DebtCardModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  double amount;
  @HiveField(2)
  String date;
  @HiveField(3)
  bool isDebt;
  @HiveField(4)
  bool? isPaid;

  DebtCardModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.isDebt,
    this.isPaid = false,
  });
}
