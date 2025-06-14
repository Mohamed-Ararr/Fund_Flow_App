import "package:flutter/material.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:go_router/go_router.dart";

import "../../../../../Core/AppColors.dart";
import "../../../../../Core/AppFonts.dart";
import "../../../../../Core/buttons.dart";

class DebtsAndAddNew extends StatelessWidget {
  const DebtsAndAddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Debts & Credits", style: AppFonts.sectionTitleStyle),
        AppButton.text(
          context,
          text: "New Transaction",
          textColor: AppColors.blueColor,
          onPressed: () {
            GoRouter.of(context).push(AppRouter.addNewDebtFormView);
          },
        ),
      ],
    );
  }
}
