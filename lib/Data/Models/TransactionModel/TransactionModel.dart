import 'package:hive/hive.dart';

part "TransactionModel.g.dart";

@HiveType(typeId: 11)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  double? spentAmount;
  @HiveField(2)
  String? date;
  @HiveField(3)
  String? desc;

  TransactionModel(
    this.title,
    this.desc,
    this.spentAmount,
    this.date,
  );
}
