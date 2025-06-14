import "package:flutter/material.dart";
import "package:fundflow/Core/buttons.dart";

import "../../../../../../../Core/AppColors.dart";

class DividerAndAddNew extends StatelessWidget {
  const DividerAndAddNew({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 20,
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.blueColor,
            height: 1,
            thickness: 0.5,
          ),
        ),
        AppButton.text(
          context,
          onPressed: onPressed,
          text: 'New Spend',
          textColor: AppColors.blueColor,
        ),
      ],
    );
  }
}
