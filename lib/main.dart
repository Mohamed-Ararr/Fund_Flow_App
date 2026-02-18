import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Data/Models/TransactionModel/TransactionModel.dart";
import "package:hive_flutter/hive_flutter.dart";

import "ContValues.dart";
import "Core/AppRouter.dart";
import "Core/Theme/AppTheme.dart";
import "Core/Theme/AppThemeController.dart";
import "Data/BLoC Manager/Add New Debt Cubit/add_new_debt_cubit.dart";
import "Data/BLoC Manager/Debt Cubit/debt_cubit.dart";
import "Data/BLoC Manager/Saving Cubit/saving_cubit.dart";
import "Data/BLoC Manager/Spent Cubit/spent_cubit.dart";
import "Data/BLoC Manager/Transaction Cubit/transaction_cubit.dart";
import "Data/BLoC Manager/User Cubit/user_cubit.dart";
import "Data/Models/BalanceEntryModel/BalanceEntryModel.dart";
import "Data/Models/Debt Card Model/DebtCardModel.dart";
import "Data/Models/Saving Card Model/SavingCardModel.dart";
import "Data/Models/Spent Card Model/SpentCardModel.dart";
import "Data/Models/Spent Detail Model/SpentDetailModel.dart";

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  // OPEN THE BOX HERE before the app starts
  await Hive.openBox('settings');
  // TOTAL BALANCE BOX
  await Hive.openBox<double>(kbalanceBox);
  // ONBOARDING SEEN BOX
  await Hive.openBox<bool>(kOnboarding);
  // SELECTED CURRENCY BOX
  await Hive.openBox<String>(kCurrency);
  // SELECTED CURRENCY CODE BOX
  await Hive.openBox<String>(kCurrencyCode);
  // TRANSACTION DETAIL BOX
  Hive.registerAdapter(TransactionModelAdapter());
  await Hive.openBox<TransactionModel>(kTransaction);
  // SPENT DETAIL BOX
  Hive.registerAdapter(SpentDetailModelAdapter());
  await Hive.openBox<SpentDetailModel>(kSpentDetailBox);
  // BALANCE HISTORY BOX
  Hive.registerAdapter(BalanceEntryModelAdapter());
  await Hive.openBox<BalanceEntryModel>(kbalanceHistoryBox);
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

  await AppThemeController.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const FundFlow(),
    ),
  );
}

class FundFlow extends StatelessWidget {
  const FundFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit()..fetchUserBalanceNew(),
        ),
        BlocProvider(
          create: (context) => TransactionCubit()..init(),
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
        BlocProvider(
          create: (context) => AddNewDebtCubit(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: AppThemeController.themeMode,
        builder: (_, mode, __) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: AppRouter.routes,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
          );
        },
      ),
    );
  }
}
