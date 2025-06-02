import 'package:fundflow/Data/Models/Spent%20Detail%20Model/SpentDetailModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

part "SpentCardModel.g.dart";

@HiveType(typeId: 0)
class SpentCardModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  double? spentAmount;
  @HiveField(2)
  String? lastUpdate;
  @HiveField(3)
  List<SpentDetailModel>? spentsList;

  SpentCardModel(
    this.title,
    this.spentAmount,
    this.lastUpdate,
    this.spentsList,
  );
}
