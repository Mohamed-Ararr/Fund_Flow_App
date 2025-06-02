import "package:flutter/material.dart";
import "package:fundflow/Core/AppFonts.dart";

class WelcomeRow extends StatelessWidget {
  const WelcomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Good to see you again!",
              style: AppFonts.userNameStyle18,
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.waving_hand,
              color: Colors.white,
            ),
          ],
        ),
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     // Icons.nightlight_round_outlined,
        //     Icons.wb_sunny_rounded,
        //     color: Colors.white,
        //     size: 30,
        //   ),
        // ),
      ],
    );
  }
}
