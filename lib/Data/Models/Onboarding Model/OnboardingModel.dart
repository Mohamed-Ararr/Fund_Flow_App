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
      title: "Welcome to Fund Flow",
      subTitle: "Your financial companion throughout your journey."),
  OnboardingModel(
      imageUrl: "assets/images/spend_track.svg",
      title: "Track your money flow",
      subTitle: "Gain valuable insights and track your money spents"),
  OnboardingModel(
      imageUrl: "assets/images/saving_money.svg",
      title: "Smart saving plans",
      subTitle:
          "Create and manage customized saving plans tailored to your goals and aspirations"),
  OnboardingModel(
      imageUrl: "assets/images/debts_loans.svg",
      title: "Manage debts and loans",
      subTitle:
          "Achieve financial freedom by efficiently managing your debts and loans"),
];
