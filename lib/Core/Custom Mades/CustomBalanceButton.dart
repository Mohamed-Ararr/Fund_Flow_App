import "package:flutter/material.dart";

class CustomBalanceButton extends StatelessWidget {
  const CustomBalanceButton(
      {super.key, this.backgroundColor, required this.text, this.onPressed});

  final Color? backgroundColor;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: backgroundColor,
        fixedSize: Size(
          MediaQuery.of(context).size.width * 0.4,
          50,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
