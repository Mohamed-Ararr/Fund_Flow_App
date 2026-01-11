import 'package:easy_localization/easy_localization.dart';

class OnboardingModel {
  String imageUrl;
  String title;
  String subTitle;

  OnboardingModel({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  });
}

List<OnboardingModel> onBoardingContents = [
  OnboardingModel(
      imageUrl: "assets/images/welcome.svg",
      title: "onboardingOneTitle".tr(),
      subTitle: "onboardingOneDescription".tr()),
  OnboardingModel(
      imageUrl: "assets/images/spend_track.svg",
      title: "onboardingTwoTitle".tr(),
      subTitle: "onboardingTwoDescription".tr()),
  OnboardingModel(
      imageUrl: "assets/images/saving_money.svg",
      title: "onboardingThreeTitle".tr(),
      subTitle: "onboardingThreeDescription".tr()),
  OnboardingModel(
      imageUrl: "assets/images/debts_loans.svg",
      title: "onboardingFourTitle".tr(),
      subTitle: "onboardingFourDescription".tr()),
];
