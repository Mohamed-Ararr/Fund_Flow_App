import "package:flutter/material.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Core/AppColors.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:go_router/go_router.dart";
import "package:hive_flutter/hive_flutter.dart";

import "SplashViewBodyCore.dart";

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    Box boardingBox = Hive.box<bool>(kOnboarding);
    dynamic isSeen = boardingBox.get(kOnboarding);
    Future.delayed(
      const Duration(seconds: 2),
      // ignore: use_build_context_synchronously
      () => GoRouter.of(context).pushReplacement(
        isSeen == null || isSeen == false
            ? AppRouter.onBoardingView
            : AppRouter.pinCode,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.blueColor,
      body: SplashViewBodyCore(),
    );
  }
}
