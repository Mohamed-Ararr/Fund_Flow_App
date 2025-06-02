import "package:flutter/material.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";
import "ButtonsRow.dart";
import "TotalBalanceWidget.dart";
import "WelcomeRow.dart";

class TopHeadlineContainer extends StatelessWidget {
  const TopHeadlineContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kMarginRL12,
      padding: kPadding15,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // stops: const [0.1, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkBlueColor,
            AppColors.blueColor,
          ],
        ),
        // color: AppColors.blueColor,
        borderRadius: kBr15,
      ),
      child: Column(
        children: const [
          WelcomeRow(),
          SizedBox(height: 25),
          TotalBalanceWidget(),
          SizedBox(height: 25),
          ButtonsRow(),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
