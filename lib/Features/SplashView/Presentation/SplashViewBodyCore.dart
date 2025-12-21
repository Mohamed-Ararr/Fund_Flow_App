import "package:flutter/material.dart";
import "package:fundflow/Core/AppTextStyles.dart";

import "../../../Core/AppColors.dart";

// class SplashViewBodyCore extends StatelessWidget {
//   const SplashViewBodyCore({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Spacer(flex: 3),
//             SplashImage(),
//             Spacer(flex: 2),
//             AppTitle(),
//             Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SplashViewBodyCore extends StatefulWidget {
  const SplashViewBodyCore({super.key});

  @override
  State<SplashViewBodyCore> createState() => _SplashViewBodyCoreState();
}

class _SplashViewBodyCoreState extends State<SplashViewBodyCore>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // AppColors.lightOrangeColor,
              AppColors.lightGreyColor,
              AppColors.primaryDark,
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/images/app-icon.png",
                    height: 100,
                  ),
                  const Spacer(),
                  SafeArea(
                    child: RichText(
                      text: TextSpan(
                        style:
                            AppTextStyles.listItemTitle(context), // base style
                        children: const [
                          TextSpan(
                            text: "Track",
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                          TextSpan(
                            text: ".",
                            style: TextStyle(
                              color: AppColors.orangeColor,
                              fontSize: 25,
                            ),
                          ),
                          TextSpan(
                            text: " Manage",
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                          TextSpan(
                            text: ".",
                            style: TextStyle(
                              color: AppColors.orangeColor,
                              fontSize: 25,
                            ),
                          ),
                          TextSpan(
                            text: " Grow",
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                          TextSpan(
                            text: ".",
                            style: TextStyle(
                              color: AppColors.orangeColor,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
