import "package:flutter/material.dart";
import "package:fundflow/Data/Models/Saving%20Card%20Model/SavingCardModel.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/Saving%20Plans%20Widgets/SavingGoalAndCurrent.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/Saving%20Plans%20Widgets/SavingProgress.dart";
import "../../../../../ContValues.dart";
import "../../../../../Core/AppFonts.dart";
import "IconAndOptionsSavingCard.dart";

class SavingCardInfo extends StatelessWidget {
  const SavingCardInfo(
      {super.key, required this.index, required this.savingCardModel});

  final int index;
  final SavingCardModel savingCardModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Container(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: kBr15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconAndOptionsSavingCard(savingCardModel: savingCardModel),
            // const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(savingCardModel.title!, style: AppFonts.font17Bold),
                const SizedBox(height: 2),
                Text(savingCardModel.createdDate!,
                    style: AppFonts.font11BoldLightGrey),
              ],
            ),
            // const SizedBox(height: 8),
            SavingGoalAndCurrent(savingCardModel: savingCardModel),
            // const SizedBox(height: 8),
            SavingProgress(savingCardModel: savingCardModel),
            // const SizedBox(height: 8),
            Text(
              "Last update: ${savingCardModel.lastSeen}",
              style: AppFonts.font12Bold,
            ),
          ],
        ),
      ),
    );
  }
}
