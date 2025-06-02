import "package:flutter/material.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:go_router/go_router.dart";

import "../../../../../Core/AppFonts.dart";

class DebtsAndAddNew extends StatelessWidget {
  const DebtsAndAddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Debts & Credits", style: AppFonts.sectionTitleStyle),
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.addNewDebtFormView);
          },
          child: Text("Add new transaction", style: AppFonts.font12Bold),
        ),
      ],
    );
  }
}
