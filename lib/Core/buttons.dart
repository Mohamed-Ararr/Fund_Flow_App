import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'AppTextStyles.dart';

class AppButton {
  const AppButton._();

  /// Main primary button (default uses AppColors.primaryDark)
  static Widget main(
    context, {
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
    double borderRadius =
        12.0, // Increased borderRadius slightly for modern look
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
  }) {
    // Default background is now primaryDark (for the "Log New Entry" style)
    final Color defaultBgColor = backgroundColor ?? AppColors.primaryDark;
    TextStyle defaultTextStyle = AppTextStyles.buttonPrimary(context);

    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
        backgroundColor: defaultBgColor,
        disabledBackgroundColor: defaultBgColor.withOpacity(0.5),
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('main_loading'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: defaultTextStyle.copyWith(
                      color: textColor ?? Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12), // Fixed non-standard 'spacing: 12'
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: defaultTextStyle.copyWith(
                  color: textColor ?? Colors.white,
                ),
              ),
      ),
    );
  }

  /// Secondary button (outline style)
  static Widget sec(
    context, {
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
    double borderRadius = 12.0,
    Color? outlineColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
  }) {
    // Default outline is now primaryDark
    final Color defaultOutlineColor = outlineColor ?? AppColors.primaryDark;
    TextStyle defaultTextStyle = AppTextStyles.buttonPrimary(context);

    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: defaultOutlineColor,
            width: 1.5,
          ),
        ),
        elevation: 0,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('sec_loading'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: defaultTextStyle.copyWith(
                      color: textColor ?? defaultOutlineColor,
                    ),
                  ),
                  const SizedBox(width: 12), // Fixed non-standard 'spacing: 12'
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? defaultOutlineColor,
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                key: const ValueKey('sec_text'),
                style: defaultTextStyle.copyWith(
                  color: textColor ?? defaultOutlineColor,
                ),
              ),
      ),
    );
  }

  /// Simple text button (for links like "View All")
  static Widget text(
    context, {
    required String text,
    required Function()? onPressed,
    bool isDisabled = false,
    bool isLoading = false,
    double borderRadius = 8.0,
    Color? textColor,
    EdgeInsetsGeometry? padding,
  }) {
    final Color defaultTextColor = textColor ?? AppColors.darkText;
    TextStyle defaultTextStyle = AppTextStyles.listItemTitle(context);

    return TextButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        padding: padding ?? EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('text_loading'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: defaultTextStyle.copyWith(
                      color: defaultTextColor,
                    ),
                  ),
                  const SizedBox(width: 12), // Fixed non-standard 'spacing: 12'
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        defaultTextColor,
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                key: const ValueKey('text_text'),
                style: defaultTextStyle.copyWith(
                  color: defaultTextColor,
                  // Removed hardcoded Colors.white override from original
                ),
              ),
      ),
    );
  }

  /// Danger-style button (e.g., delete, or logging an expense/debt)
  static Widget danger(
    context, {
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    bool isLoading = false,
    double borderRadius = 12.0,
    EdgeInsetsGeometry? padding,
  }) {
    // Uses the new warningOrange for negative actions
    const Color dangerColor = AppColors.warningOrange;
    TextStyle defaultTextStyle = AppTextStyles.buttonPrimary(context);

    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
        backgroundColor: dangerColor,
        disabledBackgroundColor: dangerColor.withOpacity(0.5),
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('danger_loading'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: defaultTextStyle.copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 12), // Fixed non-standard 'spacing: 12'
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
                style: defaultTextStyle.copyWith(color: Colors.white),
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
    double borderRadius = 12.0,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
  }) {
    final Color defaultBgColor = backgroundColor ?? AppColors.primaryDark;
    TextStyle defaultTextStyle = AppTextStyles.buttonPrimary(context);

    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: defaultBgColor,
        elevation: 0,
        disabledBackgroundColor: defaultBgColor.withOpacity(0.5),
        padding: padding ?? const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        child: isLoading
            ? Row(
                key: const ValueKey('icon_loading'),
                mainAxisSize: MainAxisSize.min,
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
                  if (text != null && text.isNotEmpty) const SizedBox(width: 8),
                  Text(
                    text!,
                    style: textStyle ??
                        defaultTextStyle.copyWith(
                          color: textColor ?? Colors.white,
                        ),
                  ),
                ],
              )
            : Row(
                key: const ValueKey('icon_text'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  if (text != null && text.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Text(
                      text,
                      style: textStyle ??
                          defaultTextStyle.copyWith(
                            color: textColor ?? Colors.white,
                          ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
