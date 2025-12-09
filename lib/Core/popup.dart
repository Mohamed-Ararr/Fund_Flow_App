import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'buttons.dart';

class Popup {
  static show(context, {required Widget child}) => showDialog(
        context: context,
        builder: (context) {
          return child;
        },
      );

  static Future<T?> showBottom<T>(context, {required Widget child}) =>
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) {
          return child;
        },
      );

  static Widget simplePopup(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color buttonBackgroundColor,
    required String title,
    required String desc,
    required String buttonTitle,
    Widget? others,
    required Function() onPressed,
  }) =>
      Dialog(
        // insetPadding: AppSpacing.spacingAll16,
        shape: RoundedRectangleBorder(
            // borderRadius: AppBorderRadius.borderRadius12,
            ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 50,
              ),
              const SizedBox(),
              Text(
                title,
                // style: AppTextStyles.bodyLarge(context).copyWith(
                //   fontWeight: FontWeight.w600,
                // ),
                textAlign: TextAlign.center,
              ),
              Text(
                desc,
                // style: AppTextStyles.caption(context),
                textAlign: TextAlign.center,
              ),
              if (others != null) others,
              const SizedBox(),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: AppButton.sec(
                      context,
                      text: 'Cancel',
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  Flexible(
                    child: AppButton.main(
                      context,
                      backgroundColor: buttonBackgroundColor,
                      text: buttonTitle,
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
