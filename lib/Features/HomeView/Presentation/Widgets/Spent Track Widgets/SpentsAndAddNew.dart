import "package:flutter/material.dart";
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
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.addNewSpentFormView);
          },
          child: Text(
            "Add new category",
            style: AppFonts.font12Bold,
          ),
        ),
      ],
    );
  }
}
