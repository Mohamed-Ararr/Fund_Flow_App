import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'AppColors.dart';

class ToastService {
  static void showSuccess(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        maxLines: 3,
        message: message,
        backgroundColor: AppColors.successTeal,
      ),
      displayDuration: const Duration(seconds: 2),
      snackBarPosition: SnackBarPosition.top,
    );
  }

  static void showError(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        maxLines: 5,
        message: message,
        backgroundColor: AppColors.redColor,
      ),
      displayDuration: const Duration(seconds: 2),
      snackBarPosition: SnackBarPosition.top,
    );
  }

  static void showInfo(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        maxLines: 3,
        message: message,
        backgroundColor: AppColors.lightBlueColor,
      ),
      displayDuration: const Duration(seconds: 2),
      snackBarPosition: SnackBarPosition.top,
    );
  }
}
