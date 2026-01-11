import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../ContValues.dart";
import "../../../../Core/AppFonts.dart";

class OnboardingDetails extends StatelessWidget {
  const OnboardingDetails(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.imageUrl});

  final String title;
  final String subTitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imageUrl,
            height: 220,
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: AppTextStyles.headline2(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            subTitle,
            style: AppTextStyles.bodyMedium(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
