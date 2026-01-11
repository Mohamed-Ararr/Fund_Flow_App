import 'package:currency_picker/currency_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Core/AppColors.dart';
import 'package:fundflow/Core/AppRouter.dart';
import 'package:fundflow/Core/AppTextStyles.dart';
import 'package:fundflow/Core/ToastService.dart';
import 'package:fundflow/Features/SettingsScreen/widgets/ReusableComponents.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../Core/Theme/AppThemeController.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  String _getLanguageDisplay() {
    final box = Hive.box('settings');
    // Use the same key we used in the Language screen
    final String? savedSelection = box.get('user_language_pref');

    // 1. If the user explicitly chose 'system' or hasn't made a choice yet
    if (savedSelection == null || savedSelection == 'system') {
      return 'followSystem'.tr();
    }

    // 2. Map the language codes to their Native names
    switch (savedSelection) {
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        children: [
          SettingsItem(
            icon: Icons.currency_exchange,
            title: "currency".tr(),
            trailing: Text(
              getCurrency(),
              style: AppTextStyles.listItemTitle(context),
            ),
            onTap: () {
              showCurrencyPicker(
                context: context,
                theme: CurrencyPickerThemeData(
                    inputDecoration: InputDecoration(
                      hintText: "searchCurrency".tr(),
                      contentPadding: kPaddingLR12,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: kBr10,
                        borderSide: const BorderSide(
                          width: 2,
                          color: AppColors.blueColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: kBr10,
                        borderSide: const BorderSide(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                    bottomSheetHeight:
                        MediaQuery.of(context).size.height * 0.8),
                currencyFilter: currencyList,
                onSelect: (currency) async {
                  Box currencyBox = Hive.box<String>(kCurrency);
                  Box currencyCodeBox = Hive.box<String>(kCurrencyCode);
                  currencyBox.put(kCurrency, currency.symbol);
                  currencyCodeBox.put(kCurrencyCode, currency.code);
                  setState(() {});
                  await Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      if (!context.mounted) return;
                      GoRouter.of(context).pop(true);
                    },
                  );
                },
              );
            },
          ),
          const Divider(color: AppColors.dividerLight),
          SettingsItem(
            icon: Icons.language,
            title: "languages".tr(),
            trailing: Text(
              _getLanguageDisplay(), // Dynamic text
              style: AppTextStyles.listItemTitle(context),
            ),
            onTap: () async {
              // Await the push so when they come back from the Language screen,
              // this screen refreshes its UI to show the new selection.
              await context.push(AppRouter.languages);
              setState(() {});
            },
          ),
          const Divider(color: AppColors.dividerLight),
          SettingsSwitch(
            icon: Icons.dark_mode_outlined,
            title: "darkMode".tr(),
            value: AppThemeController.isDarkMode(),
            onChanged: (value) {
              AppThemeController.toggle(value);
            },
          ),
        ],
      ),
    );
  }
}
