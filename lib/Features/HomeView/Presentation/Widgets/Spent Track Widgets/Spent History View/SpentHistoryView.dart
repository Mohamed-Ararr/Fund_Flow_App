import "package:flutter/material.dart";
import "package:fundflow/Data/Models/Spent%20Card%20Model/SpentCardModel.dart";

import "Widgets/SpentHistoryViewBody.dart";

class SpentHistoryView extends StatelessWidget {
  const SpentHistoryView({super.key, required this.spentCardModel});

  final SpentCardModel spentCardModel;

  @override
  Widget build(BuildContext context) {
    return SpentHistoryViewBody(spentCardModel: spentCardModel);
  }
}
