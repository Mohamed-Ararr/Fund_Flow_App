import "package:flutter/material.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/AppTitleFromHomeView.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/bodyFeatures.dart";

import "Top Headline Widgets/TopHeadlineContainer.dart";

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const AppTitleFromHomeView(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TopHeadlineContainer(),
              SizedBox(height: 20),
              BodyFeatures(),
            ],
          ),
        ),
      ),
    );
  }
}
