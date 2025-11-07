import "package:flutter/material.dart";
import "package:fundflow/Core/helper.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/Top%20Headline%20Widgets/TotalBalanceWidget.dart";

import "../../../../../Core/AppColors.dart";
import "ButtonsRow.dart";

class TopHeadlineContainer extends StatelessWidget {
  final bool collapsed;
  const TopHeadlineContainer({super.key, this.collapsed = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      color: AppColors.blueColor,
      elevation: 0,
      shadowColor: AppColors.darkBlueColor,
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 250),
        crossFadeState:
            collapsed ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: Container(
          width: Helper.width(context),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const TotalBalanceWidget(),
        ),
        secondChild: Container(
          width: Helper.width(context),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TotalBalanceWidget(),
                SizedBox(height: 20),
                ButtonsRow(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
