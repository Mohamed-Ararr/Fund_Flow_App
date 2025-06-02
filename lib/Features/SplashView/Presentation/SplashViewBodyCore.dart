import "package:flutter/material.dart";
import "package:fundflow/Features/SplashView/Presentation/SplashImage.dart";

import "AppTitle.dart";

class SplashViewBodyCore extends StatelessWidget {
  const SplashViewBodyCore({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Spacer(flex: 3),
            SplashImage(),
            Spacer(flex: 2),
            AppTitle(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
