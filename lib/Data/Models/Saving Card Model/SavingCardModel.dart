import 'package:hive_flutter/hive_flutter.dart';

part "SavingCardModel.g.dart";

@HiveType(typeId: 1)
class SavingCardModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  double? savingGoal;
  @HiveField(2)
  double? currentSaving;
  @HiveField(3)
  bool? isCompleted;
  @HiveField(4)
  String? lastSeen;
  @HiveField(5)
  String? createdDate;

  SavingCardModel({
    this.title,
    this.savingGoal,
    this.currentSaving,
    this.isCompleted,
    this.lastSeen,
    this.createdDate,
  });
}
