import "package:flutter/material.dart";
import "package:fundflow/Data/Models/Saving%20Card%20Model/SavingCardModel.dart";
import "CompletedSavingCard.dart";
import "SavingCardInfo.dart";

class SavingsCard extends StatelessWidget {
  const SavingsCard(
      {super.key, required this.index, required this.savingCardModel});

  final int index;
  final SavingCardModel savingCardModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 60,
      child: Row(
        children: [
          SavingCardInfo(index: index, savingCardModel: savingCardModel),
          const SizedBox(width: 12),
          CompletedSavingCard(savingCardModel: savingCardModel),
        ],
      ),
    );
  }
}
