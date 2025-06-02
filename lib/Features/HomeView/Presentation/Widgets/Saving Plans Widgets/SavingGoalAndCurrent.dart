import "package:flutter/material.dart";
import "package:fundflow/Data/Models/Saving%20Card%20Model/SavingCardModel.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppFonts.dart";

class SavingGoalAndCurrent extends StatelessWidget {
  const SavingGoalAndCurrent({super.key, required this.savingCardModel});

  final SavingCardModel savingCardModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${savingCardModel.currentSaving} ${getCurrency()}",
          style: AppFonts.font14Bold,
        ),
        Text(
          "${savingCardModel.savingGoal} ${getCurrency()}",
          style: AppFonts.font15Bold,
        ),
      ],
    );
  }
}
