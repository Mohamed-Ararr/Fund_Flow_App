import "package:flutter/material.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";

class DragLineBottomSheet extends StatelessWidget {
  const DragLineBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: kBr10,
        color: AppColors.orangeColor,
      ),
    );
  }
}
