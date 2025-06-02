import "package:flutter/material.dart";

import "../../../../../Core/AppColors.dart";
import "../../../../../Data/Models/Saving Card Model/SavingCardModel.dart";

class SavingProgress extends StatelessWidget {
  const SavingProgress({super.key, required this.savingCardModel});

  final SavingCardModel savingCardModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth;
        return Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlueColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  Container(
                    height: 10,
                    width: savingCardModel.currentSaving! *
                        containerWidth /
                        savingCardModel.savingGoal!,
                    decoration: BoxDecoration(
                      color: AppColors.orangeColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
