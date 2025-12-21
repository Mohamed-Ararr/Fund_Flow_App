import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Core/AppRouter.dart';
import 'package:fundflow/Core/buttons.dart';
import 'package:fundflow/Core/helper.dart';
import 'package:fundflow/Data/BLoC%20Manager/Debt%20Cubit/debt_cubit.dart';
import 'package:fundflow/Data/BLoC%20Manager/Transaction%20Cubit/transaction_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Core/AppColors.dart';
import '../../../../Core/AppTextStyles.dart';
import '../../../../Data/BLoC Manager/User Cubit/user_cubit.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  bool isBalanceHidden = false;

  @override
  void initState() {
    super.initState();
    _loadBalanceVisibility();
  }

  Future<void> _loadBalanceVisibility() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBalanceHidden = prefs.getBool('balance_hidden') ?? false;
    });
  }

  Future<void> _toggleBalance() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBalanceHidden = !isBalanceHidden;
    });
    await prefs.setBool('balance_hidden', isBalanceHidden);
  }

  @override
  Widget build(BuildContext context) {
    // Format the balance to include $ and two decimal places
    // final String formattedBalance = '\$${currentBalance.toStringAsFixed(2)}';

    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0, bottom: 24.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. App Bar Content (Greeting & Settings)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hello Again', // Can be customized with user name later
                style: AppTextStyles.headerSectionTitle(context),
              ),
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: colors.onSurface,
                ),
                onPressed: () async {
                  bool? refresh =
                      await context.push<bool>(AppRouter.settingsScreen);
                  if (context.mounted && (refresh ?? false)) {
                    context.read<TransactionCubit>().fetchTransactions();
                    context.read<DebtCubit>().fetchDebtCards();
                    setState(() {});
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // 2. Focal Point Balance (The most important element)
          Center(
            child: Column(
              children: [
                Text(
                  'Current Balance',
                  style: AppTextStyles.uiDetails(context),
                ),
                GestureDetector(
                  onTap: _toggleBalance,
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserSuccessNew) {
                        final String formattedBalance =
                            Helper.formatCurrencyWithBidi(
                          Helper.formatCurrency(state.currentBalance),
                          getCurrencySymbol(),
                        );

                        return ImageFiltered(
                          imageFilter: isBalanceHidden
                              ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Text(
                            formattedBalance,
                            style: AppTextStyles.focalPointBalance(context),
                          ),
                        );
                      } else if (state is UserFailure) {
                        return Text(state.errorMsg);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                Text(
                  getCurrency(),
                  style: AppTextStyles.uiDetails(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25.0),

          // 3. Primary Call-to-Action Button
          AppButton.icon(
            context,
            text: 'Log New Entry',
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              size: 16.0,
              color: AppColors.whiteColor,
            ),
            onPressed: () {
              context.push(AppRouter.logNewEntry);
            },
          ),
        ],
      ),
    );
  }
}
