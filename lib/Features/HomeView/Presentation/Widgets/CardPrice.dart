import "package:flutter/material.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Data/Models/Spent%20Card%20Model/SpentCardModel.dart";

import "../../../../Core/AppFonts.dart";

class CardPrice extends StatelessWidget {
  const CardPrice({super.key, required this.spentCardModel});

  final SpentCardModel spentCardModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "${spentCardModel.spentAmount}",
          style: AppFonts.font18Bold,
        ),
        const SizedBox(width: 4),
        Text(
          getCurrency(),
          style: AppFonts.font11Bold,
        ),
      ],
    );
    // return Text(
    // "10000.00 dzd",
    // style: AppFonts.font18Bold,
    // );
  }
}
