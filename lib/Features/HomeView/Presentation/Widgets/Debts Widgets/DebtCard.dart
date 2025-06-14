import "package:flutter/material.dart";
import "package:fundflow/Core/AppColors.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppFonts.dart";
import "../../../../../Data/Models/Debt Card Model/DebtCardModel.dart";

class DebtCard extends StatelessWidget {
  const DebtCard({super.key, required this.debtCardModel});

  final DebtCardModel debtCardModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        contentPadding: kPaddingLR12,
        leading: Image.asset(
          debtCardModel.isDebt ? debtorImage : creditorImage,
          height: 30,
          color: AppColors.whiteColor,
        ),
        title: Text(
          debtCardModel.title,
          style: AppTextStyles.bodyLarge(context).copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          debtCardModel.date,
          style: AppTextStyles.caption(context).copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        trailing: Text(
          "${debtCardModel.amount} ${getCurrency()}",
          style: AppTextStyles.bodyLarge(context).copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
