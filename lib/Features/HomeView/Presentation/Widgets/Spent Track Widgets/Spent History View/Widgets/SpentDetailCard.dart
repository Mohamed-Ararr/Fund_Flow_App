import "package:flutter/material.dart";
import "package:fundflow/Data/Models/Spent%20Detail%20Model/SpentDetailModel.dart";

import "../../../../../../../ContValues.dart";
import "../../../../../../../Core/AppColors.dart";
import "../../../../../../../Core/AppFonts.dart";

class SpentDetailCard extends StatelessWidget {
  const SpentDetailCard(
      {super.key, required this.spentDetailModel, required this.index});

  final SpentDetailModel spentDetailModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPadding8,
      decoration: BoxDecoration(
        borderRadius: kBr6,
        gradient: LinearGradient(
          end: Alignment.topRight,
          begin: Alignment.bottomLeft,
          colors: [AppColors.blueColor, AppColors.lightBlueColor],
        ),
      ),
      child: ListTile(
        iconColor: AppColors.orangeColor,
        leading: const Icon(
          Icons.credit_card,
          size: 35,
        ),
        title: Text(
          spentDetailModel.spentDetailTitle!,
          style: AppFonts.font18Bold,
        ),
        subtitle: Text(
          spentDetailModel.spentDetailDate!,
          style: AppFonts.font12Bold,
        ),
        trailing: Text(
          "${spentDetailModel.spentDetailAmount} ${getCurrency()}",
          style: AppFonts.font16Bold,
        ),
      ),
    );
  }
}
