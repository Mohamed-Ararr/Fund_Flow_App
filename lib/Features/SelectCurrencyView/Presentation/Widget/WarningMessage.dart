import "package:flutter/material.dart";

import "../../../../ContValues.dart";
import "../../../../Core/AppFonts.dart";

class WarningMessage extends StatelessWidget {
  const WarningMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPadding8,
      decoration: BoxDecoration(
        color: const Color.fromARGB(75, 158, 158, 158),
        borderRadius: kBr6,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Switch currency feature mid-app is unavailable currently.",
              style: AppFonts.font12Bold,
            ),
          ),
        ],
      ),
    );
  }
}
