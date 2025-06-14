import "package:flutter/material.dart";
import "package:fundflow/Core/buttons.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/bodyFeatures.dart";

import "../../../../Core/AppColors.dart";
import "../../../../Core/AppFonts.dart";
import "Top Headline Widgets/TopHeadlineContainer.dart";

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: Text(
          "Hello Again 👋",
          style: AppTextStyles.headline3(context).copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        scrolledUnderElevation: 0,
        actions: [
          AppButton.icon(
            context,
            icon: const Icon(
              Icons.history,
              size: 35,
              color: AppColors.whiteColor,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: const SafeArea(
        child: Column(
          children: [
            TopHeadlineContainer(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyFeatures(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
