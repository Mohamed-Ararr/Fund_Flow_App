import "package:flutter/material.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:go_router/go_router.dart";

import "../../../../../Core/AppFonts.dart";

class SavingsAndAddNew extends StatelessWidget {
  const SavingsAndAddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Saving Plans", style: AppFonts.sectionTitleStyle),
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.addNewSavingFormView);
          },
          child: Text(
            "Add new plan",
            style: AppFonts.font12Bold,
          ),
        ),
      ],
    );
  }
}
