import 'package:flutter/material.dart';

import '../../../../Core/AppColors.dart';

class CustomBottomAppBar extends StatefulWidget {
  final Function(int) onTap;
  final int currentIndex;

  const CustomBottomAppBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item(Icons.home_rounded, 'Home', 0),
            _item(Icons.bar_chart_rounded, 'Insights', 1),
          ],
        ),
      ),
    );
  }

  Widget _item(IconData asset, String text, int index) {
    final isActive = widget.currentIndex == index;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => widget.onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          Icon(
            asset,
            size: 25,
            color: isActive ? AppColors.primaryDark : Colors.grey,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isActive ? AppColors.primaryDark : Colors.grey,
                ),
          )
        ],
      ),
    );
  }
}
