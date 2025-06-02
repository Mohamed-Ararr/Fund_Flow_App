import "package:flutter/material.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Core/AppFonts.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:fundflow/Features/OnboardingView/Presentation/Widgets/BulletDot.dart";
import "package:fundflow/Features/OnboardingView/Presentation/Widgets/OnboardingDetails.dart";
import "package:fundflow/Features/OnboardingView/Presentation/Widgets/onBoardingButton.dart";
import "package:go_router/go_router.dart";
import "package:hive_flutter/hive_flutter.dart";

import "../../../../Data/Models/Onboarding Model/OnboardingModel.dart";

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  int currentIndex = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              Box boardingBox = Hive.box<bool>(kOnboarding);
              boardingBox.put(kOnboarding, true);
              GoRouter.of(context).push(AppRouter.selectCurrencyView);
            },
            child: Text(
              "Skip",
              style: AppFonts.font16Bold.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (value) => setState(() => currentIndex = value),
                itemCount: onBoardingContents.length,
                itemBuilder: (context, index) {
                  return OnboardingDetails(
                    imageUrl: onBoardingContents[index].imageUrl,
                    title: onBoardingContents[index].title,
                    subTitle: onBoardingContents[index].subTitle,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onBoardingContents.length,
                (index) => BulletDot(index: index, currentInd: currentIndex),
              ),
            ),
            OnboardingButton(
              title: currentIndex == 3 ? "Get Started" : "Next",
              onPressed: () {
                Box boardingBox = Hive.box<bool>(kOnboarding);
                boardingBox.put(kOnboarding, true);
                if (currentIndex == 3) {
                  GoRouter.of(context).push(AppRouter.selectCurrencyView);
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
