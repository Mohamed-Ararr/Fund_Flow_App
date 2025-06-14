import "package:flutter/material.dart";
import "package:fundflow/Core/AppColors.dart";
import "package:fundflow/Core/buttons.dart";
import "package:go_router/go_router.dart";

import "../../../../../Core/AppFonts.dart";
import "../../../../../Core/AppRouter.dart";

class SpentsAndAddNew extends StatelessWidget {
  const SpentsAndAddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Spend Track", style: AppFonts.sectionTitleStyle),
        AppButton.text(
          context,
          text: "New Spend",
          textColor: AppColors.blueColor,
          onPressed: () {
            GoRouter.of(context).push(AppRouter.addNewSpentFormView);
          },
        ),
      ],
    );
  }
}
