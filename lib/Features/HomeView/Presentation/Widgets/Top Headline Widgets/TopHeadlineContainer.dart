import "package:flutter/material.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";
import "ButtonsRow.dart";
import "TotalBalanceWidget.dart";
import "WelcomeRow.dart";

class TopHeadlineContainer extends StatelessWidget {
  const TopHeadlineContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: kMarginRL12,
    //   padding: kPadding15,
    //   decoration: BoxDecoration(
    //     gradient: const LinearGradient(
    //       // stops: const [0.1, 1],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [
    //         AppColors.darkBlueColor,
    //         AppColors.blueColor,
    //       ],
    //     ),
    //     // color: AppColors.blueColor,
    //     borderRadius: kBr15,
    //   ),
    //   height: deviceHeight(context) * 0.25,
    //   child: const Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     spacing: 25,
    //     children: [
    //       WelcomeRow(),
    //       TotalBalanceWidget(),
    //       ButtonsRow(),
    //     ],
    //   ),
    // );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.deepPurple,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hello, Robert 👋",
                style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 10),
            const Text("Current Balance",
                style: TextStyle(color: Colors.white54)),
            const Text("\$12,560.00",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_upward),
                  label: const Text("Top Up"),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.sync_alt),
                  label: const Text("Transfer"),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
