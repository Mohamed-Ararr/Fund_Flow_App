import "package:flutter/material.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/Debts%20Widgets/DebtsGridview.dart";

import "Debts Widgets/DebtsAndAddNew.dart";
import "Saving Plans Widgets/SavingsAndAddNew.dart";
import "Saving Plans Widgets/SavingsGridView.dart";
import "Spent Track Widgets/SpentGridview.dart";
import "Spent Track Widgets/SpentsAndAddNew.dart";

class BodyFeatures extends StatelessWidget {
  const BodyFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpentsAndAddNew(),
          SizedBox(height: 10),
          SpentGridview(),
          SizedBox(height: 25),
          SavingsAndAddNew(),
          SizedBox(height: 10),
          SavingsGridview(),
          SizedBox(height: 25),
          DebtsAndAddNew(),
          SizedBox(height: 10),
          DebtsGridview(),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
