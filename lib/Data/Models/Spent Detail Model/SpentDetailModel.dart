import 'package:hive_flutter/hive_flutter.dart';

part "SpentDetailModel.g.dart";

@HiveType(typeId: 4)
class SpentDetailModel extends HiveObject {
  @HiveField(0)
  String? spentDetailTitle;
  @HiveField(1)
  String? spentDetailAmount;
  @HiveField(2)
  String? spentDetailDate;

  SpentDetailModel(
    this.spentDetailTitle,
    this.spentDetailAmount,
    this.spentDetailDate,
  );
}
