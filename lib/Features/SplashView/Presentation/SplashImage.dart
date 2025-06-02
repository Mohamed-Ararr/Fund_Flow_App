import "package:flutter/material.dart";

import "../../../ContValues.dart";

class SplashImage extends StatefulWidget {
  const SplashImage({super.key});

  @override
  State<SplashImage> createState() => _SplashImageState();
}

class _SplashImageState extends State<SplashImage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    controller.forward();
    controller.forward().then((_) => controller.stop());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(controller),
            child: ScaleTransition(
              scale: Tween(begin: 10.0, end: 1.0).animate(controller),
              child: Container(
                padding: kPadding10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Image.asset(
                  "assets/images/app-icon.png",
                  height: 60,
                ),
              ),
            ),
          );
        });
  }
}
