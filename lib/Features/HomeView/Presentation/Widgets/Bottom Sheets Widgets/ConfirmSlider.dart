import "package:action_slider/action_slider.dart";
import "package:flutter/material.dart";

import "../../../../../Core/AppColors.dart";

class ConfirmSlider extends StatelessWidget {
  const ConfirmSlider({super.key, this.action});

  final dynamic Function(ActionSliderController)? action;

  @override
  Widget build(BuildContext context) {
    return ActionSlider.standard(
      width: MediaQuery.of(context).size.width * 0.8,
      sliderBehavior: SliderBehavior.stretch,
      icon: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 22,
      ),
      borderWidth: 4,
      toggleColor: AppColors.orangeColor,
      backgroundColor: AppColors.blueColor,
      height: 50,
      backgroundBorderRadius: BorderRadius.circular(50),
      action: action,
      child: const Text(
        'Slide To Confirm',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
