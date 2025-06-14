import "package:flutter/material.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/Top%20Headline%20Widgets/TotalBalanceWidget.dart";

import "../../../../../Core/AppColors.dart";
import "ButtonsRow.dart";

class TopHeadlineContainer extends StatelessWidget {
  const TopHeadlineContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: kMarginRL12,
    //   padding: kPadding15,
    //   decoration: BoxDecoration(
    //     gradient: const LinearGradient(
    //       // stops: const [0.1, 1],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [
    //         AppColors.darkBlueColor,
    //         AppColors.blueColor,
    //       ],
    //     ),
    //     // color: AppColors.blueColor,
    //     borderRadius: kBr15,
    //   ),
    //   height: deviceHeight(context) * 0.25,
    //   child: const Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     spacing: 25,
    //     children: [
    //       WelcomeRow(),
    //       TotalBalanceWidget(),
    //       ButtonsRow(),
    //     ],
    //   ),
    // );
    return const Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      color: AppColors.blueColor,
      elevation: 4,
      shadowColor: AppColors.darkBlueColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TotalBalanceWidget(),
            SizedBox(height: 20),
            ButtonsRow(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
