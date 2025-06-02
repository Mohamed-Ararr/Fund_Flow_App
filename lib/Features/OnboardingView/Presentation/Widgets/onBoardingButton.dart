import "package:flutter/material.dart";
import "package:fundflow/Core/AppFonts.dart";

import "../../../../ContValues.dart";
import "../../../../Core/AppColors.dart";

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({super.key, this.onPressed, required this.title});

  final Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueColor,
          elevation: 0,
          fixedSize: Size(MediaQuery.of(context).size.width, 50),
          shape: RoundedRectangleBorder(borderRadius: kBr10),
        ),
        child: Text(title, style: AppFonts.font18Bold),
      ),
    );
  }
}
