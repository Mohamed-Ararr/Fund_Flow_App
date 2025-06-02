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
        children: [
          SvgPicture.asset(
            imageUrl,
            height: 180,
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: AppFonts.font22Bold,
          ),
          const SizedBox(height: 5),
          Text(
            subTitle,
            style: AppFonts.font14BoldLightGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
