import "package:flutter/material.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:go_router/go_router.dart";
import "package:hive_flutter/hive_flutter.dart";

// class SplashViewBody extends StatefulWidget {
//   const SplashViewBody({super.key});

//   @override
//   State<SplashViewBody> createState() => _SplashViewBodyState();
// }

// class _SplashViewBodyState extends State<SplashViewBody> {
//   @override
//   void initState() {
//     Box boardingBox = Hive.box<bool>(kOnboarding);
//     dynamic isSeen = boardingBox.get(kOnboarding);
//     Future.delayed(
//       const Duration(seconds: 2),
//       // ignore: use_build_context_synchronously
//       () => GoRouter.of(context).pushReplacement(
//         isSeen == null || isSeen == false
//             ? AppRouter.onBoardingView
//             : AppRouter.pinCode,
//       ),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: AppColors.blueColor,
//       body: SplashViewBodyCore(),
//     );
//   }
// }

class FundFlowSplashView extends StatefulWidget {
  const FundFlowSplashView({super.key});

  @override
  State<FundFlowSplashView> createState() => _FundFlowSplashViewState();
}

class _FundFlowSplashViewState extends State<FundFlowSplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 1600), _navigate);
  }

  void _navigate() {
    final box = Hive.box<bool>(kOnboarding);
    final isSeen = box.get(kOnboarding, defaultValue: false);

    Box currencyBox = Hive.box<String>(kCurrencyCode);
    String? selectedCurrency = currencyBox.get(kCurrencyCode);

    if (!mounted) return;

    context.pushReplacement(
      isSeen!
          ? selectedCurrency != null && selectedCurrency.isNotEmpty
              ? AppRouter.pinCode
              : AppRouter.selectCurrencyView
          : AppRouter.onBoardingView,
      // AppRouter.homeView,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Image.asset(
              "assets/images/app-icon.png",
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
