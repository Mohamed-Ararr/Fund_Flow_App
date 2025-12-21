import 'package:flutter/material.dart';

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
    final colors = Theme.of(context).colorScheme;
    return BottomAppBar(
      color: colors.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: _item(Icons.home_rounded, 'Home', 0)),
          Expanded(child: _item(Icons.bar_chart_rounded, 'Insights', 1)),
        ],
      ),
    );
  }

  Widget _item(IconData asset, String text, int index) {
    final isActive = widget.currentIndex == index;
    final colors = Theme.of(context).colorScheme;
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
            color: isActive
                ? colors.onSurface
                : colors.onSurface.withValues(
                    alpha: 0.3,
                  ),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isActive
                      ? colors.onSurface
                      : colors.onSurface.withValues(
                          alpha: 0.3,
                        ),
                ),
          )
        ],
      ),
    );
  }
}
