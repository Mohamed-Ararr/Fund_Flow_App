import "package:flutter/material.dart";

import "../../../../Core/AppFonts.dart";

class AppTitleFromHomeView extends StatelessWidget {
  const AppTitleFromHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "FUND FLOW",
        style: AppFonts.appTitleInHomeViewStyle,
      ),
    );
  }
}
