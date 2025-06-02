import "package:flutter/material.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";
import "../../../../../Core/Custom Mades/CustomPopUpOptionSavingPlans.dart";
import "../../../../../Data/Models/Saving Card Model/SavingCardModel.dart";

class IconAndOptionsSavingCard extends StatelessWidget {
  const IconAndOptionsSavingCard({super.key, required this.savingCardModel});

  final SavingCardModel savingCardModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.orangeColor,
            borderRadius: kBr10,
          ),
          child: Image.asset(
            savingImage,
            height: 20,
          ),
        ),
        CustomPopupOptionSavingPlans(savingCardModel: savingCardModel),
      ],
    );
  }
}
