import "package:flutter/material.dart";

import "../../../../../Core/Custom Mades/CustomOptionRow.dart";

class MultiServiceButton extends StatelessWidget {
  const MultiServiceButton(
      {super.key, this.onTap, required this.title, required this.icon});

  final Function()? onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomOptionRow(
        title: title,
        // iconData: Icons.delete_outline_rounded,
        iconData: icon,
      ),
    );
  }
}
