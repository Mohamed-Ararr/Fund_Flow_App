import "package:flutter/material.dart";

import "../../../../../../../ContValues.dart";
import "../../../../../../../Core/AppColors.dart";
import "../../../../../../../Core/AppFonts.dart";

class TotalSpent extends StatelessWidget {
  const TotalSpent({super.key, required this.lastUpdate, required this.amount});

  final String lastUpdate;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: kBr6,
        color: AppColors.orangeColor,
      ),
      padding: kPadding8,
      child: ListTile(
        title: Text("Total Spent", style: AppFonts.font18Bold),
        subtitle: Text(
          lastUpdate,
          style: AppFonts.font12Bold,
        ),
        trailing: Text(
          "$amount ${getCurrency()}",
          style: AppFonts.font16Bold,
        ),
      ),
    );
  }
}
