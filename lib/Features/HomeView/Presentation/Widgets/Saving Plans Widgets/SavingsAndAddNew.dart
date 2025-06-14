import "package:flutter/material.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:go_router/go_router.dart";

import "../../../../../Core/AppColors.dart";
import "../../../../../Core/AppFonts.dart";
import "../../../../../Core/buttons.dart";

class SavingsAndAddNew extends StatelessWidget {
  const SavingsAndAddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Saving Plans", style: AppFonts.sectionTitleStyle),
        AppButton.text(
          context,
          text: "New Plan",
          textColor: AppColors.blueColor,
          onPressed: () {
            GoRouter.of(context).push(AppRouter.addNewSavingFormView);
          },
        ),
      ],
    );
  }
}
