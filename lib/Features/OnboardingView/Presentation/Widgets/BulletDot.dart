import "package:flutter/material.dart";

import "../../../../ContValues.dart";
import "../../../../Core/AppColors.dart";

class BulletDot extends StatelessWidget {
  const BulletDot({super.key, required this.index, required this.currentInd});

  final int index;
  final int currentInd;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 8,
      width: currentInd == index ? 35 : 8,
      decoration: BoxDecoration(
        color: AppColors.lightBlueColor,
        borderRadius: kBrHalf,
      ),
    );
  }
}
