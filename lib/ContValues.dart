import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

BorderRadius kBrHalf = BorderRadius.circular(100);
BorderRadius kBr10 = BorderRadius.circular(10);
BorderRadius kBr6 = BorderRadius.circular(6);
BorderRadius kBr15 = BorderRadius.circular(15);
BorderRadius kBrTopLR = const BorderRadius.only(
  topLeft: Radius.circular(12),
  topRight: Radius.circular(12),
);
BorderRadius kBrBottomLR = const BorderRadius.only(
  bottomLeft: Radius.circular(12),
  bottomRight: Radius.circular(12),
);
EdgeInsets kPaddingLR12 = const EdgeInsets.symmetric(horizontal: 12);
EdgeInsets kPaddingTB15 = const EdgeInsets.symmetric(vertical: 15);
EdgeInsets kPadding15 = const EdgeInsets.all(15);
EdgeInsets kPadding30 = const EdgeInsets.all(30);
EdgeInsets kPadding12 = const EdgeInsets.all(12);
EdgeInsets kPadding10 = const EdgeInsets.all(10);
EdgeInsets kPadding8 = const EdgeInsets.all(8);
EdgeInsets kPadding5TB10LR =
    const EdgeInsets.symmetric(vertical: 8, horizontal: 10);
EdgeInsets kMarginRL12 = const EdgeInsets.symmetric(horizontal: 12);
EdgeInsets kMarginTB5 = const EdgeInsets.symmetric(vertical: 5);

double deviceHeight(context) => MediaQuery.sizeOf(context).height;

const String kUserBox = "accountBox";
const String kbalanceBox = "balanceBox";
const String kbalanceHistoryBox = 'balanceHistoryBox'; // New Box for charts
const String kOnboarding = "kOnboarding";
const String kCurrency = "kCurrency";
const String kCurrencyCode = "kCurrencyCode";
const String kTransaction = "kTransaction";
const String kSpentBox = "kSpentBox";
const String kSpentDetailBox = "kSpentDetailBox";
const String kSpentCardsListBox = "kSpentCardsListBox";
const String kSavingBox = "kSavingBox";
const String kDebtBox = "kDebtBox";

const String debtorImage = "assets/images/debtor-icon.png";
const String creditorImage = "assets/images/creditor-icon.png";
const String spentImage = "assets/images/spent-icon.png";
const String savingImage = "assets/images/saving-plan.png";
const String emptyListImage = "assets/images/emptyAnimation.json";

goBackFunction(context) {
  GoRouter.of(context).pop();
}

List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "June",
  "July",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec",
];

List<String> currencyList = [
  'AED',
  'AFN',
  'ANG',
  'ARS',
  'AWG',
  'BHD',
  'BOB',
  'BRL',
  'BSD',
  'BWP',
  'BZD',
  'CAD',
  'CHF',
  'CLP',
  'CNY',
  'COP',
  'CRC',
  'CUP',
  'DZD',
  'EGP',
  'EUR',
  'GBP',
  'GHS',
  'GTQ',
  'GYD',
  'HKD',
  'HNL',
  'HUF',
  'IDR',
  'INR',
  'IQD',
  'IRR',
  'JMD',
  'JPY',
  'KES',
  'KRW',
  'KWD',
  'LBP',
  'LYD',
  'MAD',
  'MYR',
  'MXN',
  'NGN',
  'NOK',
  'NZD',
  'PAB',
  'PEN',
  'PHP',
  'PKR',
  'PYG',
  'QAR',
  'RUB',
  'SAR',
  'SEK',
  'SGD',
  'SOS',
  'SRD',
  'SVC',
  'SYP',
  'THB',
  'TND',
  'TRY',
  'TWD',
  'UGX',
  'USD',
  'UYU',
  'VND',
  'ZAR',
  'ZMW',
  'ZWL',
];

showSnackBarMessage(bool result, bool warning, context, String successMsg,
    String warningMsg, String errorMsg) {
  showTopSnackBar(
    displayDuration: const Duration(milliseconds: 800),
    Overlay.of(context),
    result
        ? warning
            ? CustomSnackBar.info(
                backgroundColor: const Color.fromARGB(255, 247, 123, 85),
                message: warningMsg,
              )
            : CustomSnackBar.success(
                message: successMsg,
              )
        : CustomSnackBar.error(
            message: errorMsg,
          ),
  );
}

sliderSuccessOperation(ActionSliderController controller) async {
  controller.success();
  await Future.delayed(const Duration(milliseconds: 800));
}

sliderFailureOperation(ActionSliderController controller) async {
  controller.failure();
  await Future.delayed(const Duration(milliseconds: 800));
  controller.reset();
}

String getCurrency() {
  Box currencyBox = Hive.box<String>(kCurrencyCode);
  String selectedCurrency = currencyBox.get(kCurrencyCode);
  return selectedCurrency;
}

String getCurrencySymbol() {
  Box currencyBox = Hive.box<String>(kCurrency);
  String selectedCurrency = currencyBox.get(kCurrency);
  return selectedCurrency;
}
