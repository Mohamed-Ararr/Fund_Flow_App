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
        color: AppColors.blueColor,
        // gradient: const LinearGradient(
        //   end: Alignment.topRight,
        //   begin: Alignment.bottomLeft,
        //   colors: [AppColors.blueColor, AppColors.lightBlueColor],
        // ),
      ),
      child: ListTile(
        iconColor: AppColors.orangeColor,
        leading: const Icon(
          Icons.credit_card,
          size: 35,
        ),
        title: Text(
          spentDetailModel.spentDetailTitle!,
          style: AppTextStyles.bodyLarge(context).copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          spentDetailModel.spentDetailDate!,
          style: AppTextStyles.caption(context).copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        trailing: Text(
          "${spentDetailModel.spentDetailAmount} ${getCurrency()}",
          style: AppTextStyles.bodyLarge(context).copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
