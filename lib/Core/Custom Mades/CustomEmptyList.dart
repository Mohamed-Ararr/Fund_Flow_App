import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "../../ContValues.dart";

class CustomEmptyList extends StatelessWidget {
  const CustomEmptyList(
      {super.key, required this.title, this.onTap, required this.buttonTitle});

  final String title;
  final String buttonTitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        emptyListImage,
        height: 200,
        repeat: false,
      ),
    );
  }
}
