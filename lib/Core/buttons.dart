import 'package:flutter/material.dart';
import 'package:fundflow/Core/AppFonts.dart';

import 'AppColors.dart';

class AppButton {
  const AppButton._();

  /// Main primary button
  static Widget main(
    context, {
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
    double borderRadius = 10.0,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width, 45),
        backgroundColor: backgroundColor ?? AppColors.blueColor,
        disabledBackgroundColor: backgroundColor ?? AppColors.blueColor,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('main_loading'),
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.buttonText(context).copyWith(
                      color: textColor ?? Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                key: const ValueKey('main_text'),
                style: AppTextStyles.buttonText(context).copyWith(
                  color: textColor ?? Colors.white,
                ),
              ),
      ),
    );
  }

  /// sec primary button
  static Widget sec(
    context, {
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
    double borderRadius = 10.0,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width, 45),
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: backgroundColor ?? AppColors.blueColor,
            width: 1,
          ),
        ),
        elevation: 0,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('sec_loading'),
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.buttonText(context).copyWith(
                      color: textColor ?? Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                key: const ValueKey('sec_text'),
                style: AppTextStyles.buttonText(context).copyWith(
                  color: textColor ?? AppColors.blueColor,
                ),
              ),
      ),
    );
  }

  static Widget text(
    context, {
    required String text,
    required Function()? onPressed,
    bool isDisabled = false,
    bool isLoading = false,
    double borderRadius = 10.0,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
  }) {
    return TextButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('text_loading'),
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.buttonText(context).copyWith(
                      color: textColor ?? AppColors.blueColor,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                key: const ValueKey('text_text'),
                style: AppTextStyles.buttonText(context).copyWith(
                  color: textColor ?? Colors.white,
                ),
              ),
      ),
    );
  }

  /// Danger-style button (e.g. delete, logout)
  static Widget danger(
    context, {
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
    double borderRadius = 10.0,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
        backgroundColor: AppColors.redColor,
        disabledBackgroundColor: AppColors.redColor,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('danger_loading'),
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.buttonText(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                key: const ValueKey('danger_text'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  /// Button with icon
  static Widget icon(
    context, {
    String? text,
    required Widget icon,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
    double borderRadius = 10.0,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        // minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
        backgroundColor: backgroundColor ?? AppColors.blueColor,
        elevation: 0,
        disabledBackgroundColor: backgroundColor ?? AppColors.blueColor,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('icon_loading'),
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? Colors.white,
                      ),
                    ),
                  ),
                  if (text != null && text.isNotEmpty)
                    Text(
                      text,
                      style: AppTextStyles.buttonText(context).copyWith(
                        color: textColor ?? Colors.white,
                      ),
                    ),
                ],
              )
            : Row(
                key: const ValueKey('icon_text'),
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  icon,
                  if (text != null && text.isNotEmpty)
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
