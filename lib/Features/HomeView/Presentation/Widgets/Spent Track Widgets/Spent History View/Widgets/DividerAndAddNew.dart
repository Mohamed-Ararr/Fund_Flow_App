import "package:flutter/material.dart";

import "../../../../../../../Core/AppColors.dart";
import "../../../../../../../Core/AppFonts.dart";

class DividerAndAddNew extends StatelessWidget {
  const DividerAndAddNew({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Divider(
            color: AppColors.darkBlueColor,
            height: 3,
            thickness: 1.5,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "Add new spend",
            style: AppFonts.font15Bold,
          ),
        ),
      ],
    );
  }
}
