import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/Data/BLoC%20Manager/Add%20New%20Debt%20Cubit/add_new_debt_cubit.dart';
import 'package:fundflow/Data/BLoC%20Manager/Add%20New%20Saving%20Cubit/add_new_saving_cubit.dart';
import 'package:fundflow/Data/BLoC%20Manager/Add%20New%20Spent%20Cubit/add_new_spent_cubit.dart';
import 'package:fundflow/Data/Models/Spent%20Card%20Model/SpentCardModel.dart';
import 'package:fundflow/Features/AddNewDebtFormView/Presentation/AddNewDebtFormView.dart';
import 'package:fundflow/Features/AddNewSavingFormView/Presentation/AddNewSavingFormView.dart';
import 'package:fundflow/Features/AddNewSpentFormView/Presentation/AddNewSpentFormView.dart';
import 'package:fundflow/Features/HistoryView/Presentation/HistoryView.dart';
import 'package:fundflow/Features/HomeView/Presentation/HomeView.dart';
import 'package:fundflow/Features/HomeView/Presentation/Widgets/Spent%20Track%20Widgets/Spent%20History%20View/SpentHistoryView.dart';
import 'package:fundflow/Features/OnboardingView/Presentation/OnboardingView.dart';
import 'package:fundflow/Features/SelectCurrencyView/Presentation/SelectCurrencyView.dart';
import 'package:fundflow/Features/SplashView/Presentation/SplashView.dart';
import 'package:go_router/go_router.dart';

import '../Features/HomeView/Presentation/NewComponents/LogNewEntry.dart';
import '../Features/PinCode/PinCode.dart';
import '../Features/SeeAllDebts/SeeAllDebts.dart';
import '../Features/SeeAllTransactions/SeeAllTransactions.dart';
import '../Features/SettingsScreen/SettingsScreen.dart';

class AppRouter {
  static String homeView = "/homeView";
  static String spentHistoryView = "/spentHistoryView";
  static String onBoardingView = "/onBoardingView";
  static String selectCurrencyView = "/selectCurrencyView";
  static String topUpBalanceView = "/topUpBalanceView";
  static String addNewSavingFormView = "/addNewSavingFormView";
  static String addNewSpentFormView = "/addNewSpentFormView";
  static String addNewDebtFormView = "/addNewDebtFormView";
  static String historyView = "/historyView";

  // NEW UPDATES ROUTES
  static String logNewEntry = "/logNewEntry";
  static String seeAllTransactions = "/seeAllTransactions";
  static String seeAllDebts = "/seeAllDebts";
  static String settingsScreen = "/settingsScreen";
  static String pinCode = "/pinCode";

  static final routes = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: ((context, state) => const SplashView()),
      ),
      GoRoute(
        path: homeView,
        builder: ((context, state) => const HomeView()),
      ),
      GoRoute(
        path: spentHistoryView,
        builder: ((context, state) => SpentHistoryView(
              spentCardModel: state.extra as SpentCardModel,
            )),
      ),
      GoRoute(
        path: onBoardingView,
        builder: ((context, state) => const OnboardingView()),
      ),
      GoRoute(
        path: selectCurrencyView,
        builder: ((context, state) => const SelectCurrencyView()),
      ),
      GoRoute(
        path: addNewSavingFormView,
        builder: ((context, state) => BlocProvider(
              create: (context) => AddNewSavingCubit(),
              child: const AddNewSavingFormView(),
            )),
      ),
      GoRoute(
        path: addNewSpentFormView,
        builder: ((context, state) => BlocProvider(
              create: (context) => AddNewSpentCubit(),
              child: const AddNewSpentFormView(),
            )),
      ),
      GoRoute(
        path: addNewDebtFormView,
        builder: ((context, state) => BlocProvider(
              create: (context) => AddNewDebtCubit(),
              child: const AddNewDebtFormView(),
            )),
      ),
      GoRoute(
        path: historyView,
        builder: ((context, state) => const HistoryView()),
      ),

      // NEW UPDATES ROUTES
      GoRoute(
        path: logNewEntry,
        builder: ((context, state) => const LogNewEntryView()),
      ),
      GoRoute(
        path: seeAllTransactions,
        builder: ((context, state) => const SeeAllTransactions()),
      ),
      GoRoute(
        path: seeAllDebts,
        builder: ((context, state) => const SeeAllDebts()),
      ),
      GoRoute(
        path: settingsScreen,
        builder: ((context, state) => const SettingsScreen()),
      ),
      GoRoute(
        path: pinCode,
        builder: ((context, state) => const PinCode()),
      ),
    ],
  );
}
