import "package:flutter/material.dart";

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
        ),
        title: Text(debtCardModel.title, style: AppFonts.font16Bold),
        subtitle: Text(debtCardModel.date, style: AppFonts.font12Bold),
        trailing: Text(
          "${debtCardModel.amount} ${getCurrency()}",
          style: AppFonts.font16Bold,
        ),
      ),
    );
  }
}
