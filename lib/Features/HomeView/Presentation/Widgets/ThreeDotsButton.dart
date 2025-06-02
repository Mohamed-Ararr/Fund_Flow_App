import "package:flutter/material.dart";

import "../../../../ContValues.dart";

class ThreeDotsButton extends StatelessWidget {
  const ThreeDotsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(88, 158, 158, 158),
        borderRadius: kBr6,
      ),
      child: const Icon(Icons.more_horiz_rounded),
    );
  }
}
