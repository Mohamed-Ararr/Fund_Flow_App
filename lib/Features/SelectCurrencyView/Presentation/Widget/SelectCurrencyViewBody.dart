import "package:currency_picker/currency_picker.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:fundflow/Core/AppColors.dart";
import "package:fundflow/Core/AppFonts.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:fundflow/Core/buttons.dart";
import "package:go_router/go_router.dart";
import "package:hive_flutter/hive_flutter.dart";

import "../../../../ContValues.dart";

class SelectCurrencyViewBody extends StatelessWidget {
  const SelectCurrencyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: kPadding15,
            child: Column(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    "assets/images/welcome.svg",
                    height: 200,
                  ),
                ),
                Text(
                  "Select currency to continue with",
                  style: AppTextStyles.headline3(context),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                AppButton.main(
                  context,
                  onPressed: () {
                    showCurrencyPicker(
                      context: context,
                      theme: CurrencyPickerThemeData(
                          inputDecoration: InputDecoration(
                            hintText: "Search currency",
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
                        await Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (!context.mounted) return;
                            GoRouter.of(context).go(AppRouter.pinCode);
                          },
                        );
                      },
                    );
                  },
                  text: "Select a currency",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
