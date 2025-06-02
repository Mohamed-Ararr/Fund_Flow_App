import "package:flutter/material.dart";

class CustomOptionRow extends StatelessWidget {
  const CustomOptionRow(
      {super.key,
      this.color,
      this.onTap,
      required this.iconData,
      required this.title});

  final Color? color;
  final Function()? onTap;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 20,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
