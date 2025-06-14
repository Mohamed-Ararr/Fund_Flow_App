import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Core/theme.dart";
import "package:hive_flutter/hive_flutter.dart";

import "ContValues.dart";
import "Core/AppRouter.dart";
import "Data/BLoC Manager/Debt Cubit/debt_cubit.dart";
import "Data/BLoC Manager/Saving Cubit/saving_cubit.dart";
import "Data/BLoC Manager/Spent Cubit/spent_cubit.dart";
import "Data/BLoC Manager/User Cubit/user_cubit.dart";
import "Data/Models/Debt Card Model/DebtCardModel.dart";
import "Data/Models/Saving Card Model/SavingCardModel.dart";
import "Data/Models/Spent Card Model/SpentCardModel.dart";
import "Data/Models/Spent Detail Model/SpentDetailModel.dart";

main() async {
  await Hive.initFlutter();
  // TOTAL BALANCE BOX
  await Hive.openBox<double>(kbalanceBox);
  // ONBOARDING SEEN BOX
  await Hive.openBox<bool>(kOnboarding);
  // SELECTED CURRENCY BOX
  await Hive.openBox<String>(kCurrency);
  // SPENT DETAIL BOX
  Hive.registerAdapter(SpentDetailModelAdapter());
  await Hive.openBox<SpentDetailModel>(kSpentDetailBox);
  // SPENT TRACK BOX
  Hive.registerAdapter(SpentCardModelAdapter());
  await Hive.openBox<SpentCardModel>(kSpentBox);
  // SAVING PLANS CARDS BOX
  Hive.registerAdapter(SavingCardModelAdapter());
  await Hive.openBox<SavingCardModel>(kSavingBox);
  // DEBT & CREDITOR CARDS BOX
  Hive.registerAdapter(DebtCardModelAdapter());
  await Hive.openBox<DebtCardModel>(kDebtBox);

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(const FundFlow());
}

class FundFlow extends StatelessWidget {
  const FundFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit()..fetchUserBalance(),
        ),
        BlocProvider(
          create: (context) => SpentCubit()..fetchSpentCards(),
        ),
        BlocProvider(
          create: (context) => SavingCubit()..fetchSavingCards(),
        ),
        BlocProvider(
          create: (context) => DebtCubit()..fetchDebtCards(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.routes,
        // theme: ThemeData(
        //   fontFamily: "Quicksand",
        //   canvasColor: AppColors.lightGreyColor,
        // ),
        theme: lightTheme.copyWith(),
      ),
    );
  }
}
