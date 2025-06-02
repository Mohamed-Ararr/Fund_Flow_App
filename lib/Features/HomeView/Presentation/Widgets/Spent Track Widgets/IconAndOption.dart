import "package:flutter/material.dart";
import "package:fundflow/Core/AppColors.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/Custom Mades/CustomPopupOptions.dart";
import "../../../../../Data/Models/Spent Card Model/SpentCardModel.dart";

class IconAndOption extends StatelessWidget {
  const IconAndOption({super.key, required this.spentCardModel});

  final SpentCardModel spentCardModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: kBr10,
          ),
          child: Image.asset(
            spentImage,
            height: 20,
            color: Colors.white,
          ),
        ),
        CustomPopupOptions(spentCardModel: spentCardModel),
      ],
    );
  }
}
