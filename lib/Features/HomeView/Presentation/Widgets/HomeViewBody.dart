import "package:flutter/material.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/bodyFeatures.dart";

import "../../../../Core/AppColors.dart";
import "../../../../Core/AppFonts.dart";
import "Top Headline Widgets/TopHeadlineContainer.dart";

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final ScrollController _scrollController = ScrollController();
  double _topHeight = 190.0; // initial height

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // shrink between 220 → 90
    double offset = _scrollController.offset;
    double newHeight = (190 - offset).clamp(110, 190);
    if (newHeight != _topHeight) {
      setState(() => _topHeight = newHeight);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: _topHeight,
              child: TopHeadlineContainer(
                collapsed: _topHeight <= 100,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: const Column(
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
