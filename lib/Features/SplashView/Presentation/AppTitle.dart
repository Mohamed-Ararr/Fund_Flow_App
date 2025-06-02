import "package:flutter/material.dart";

import "../../../ContValues.dart";
import "../../../Core/AppColors.dart";

class AppTitle extends StatefulWidget {
  const AppTitle({super.key});

  @override
  State<AppTitle> createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> titleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    controller.forward();
    titleAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: titleAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "FUND FLOW",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: kBrHalf,
              color: AppColors.orangeColor,
            ),
          ),
        ],
      ),
    );
  }
}
