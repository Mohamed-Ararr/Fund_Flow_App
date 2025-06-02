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
      subTitle: "Your financial companion for a secure and prosperous future."),
  OnboardingModel(
      imageUrl: "assets/images/spend_track.svg",
      title: "Track your money flow",
      subTitle:
          "Gain valuable insights into your financial habits and expenditures by easily tracing your money spents"),
  OnboardingModel(
      imageUrl: "assets/images/saving_money.svg",
      title: "Smart saving plans",
      subTitle:
          "Transform your financial future by creating and managing customized saving plans tailored to your goals and aspirations"),
  OnboardingModel(
      imageUrl: "assets/images/debts_loans.svg",
      title: "Manage debts and loans",
      subTitle:
          "Take control of your financial obligations and achieve financial freedom by efficiently managing your debts and loans"),
];
