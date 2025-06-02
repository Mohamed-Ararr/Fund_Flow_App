import "package:flutter/material.dart";

import "../AppColors.dart";

class CustomDeleteButton extends StatelessWidget {
  const CustomDeleteButton({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.delete_outline,
        size: 30,
        color: AppColors.redColor,
      ),
    );
  }
}
