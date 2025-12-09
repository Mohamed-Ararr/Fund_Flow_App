import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/Core/AppRouter.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../ContValues.dart';
import '../../../../Core/AppColors.dart';
import '../../../../Core/AppTextStyles.dart';
import '../../../../Core/Custom Mades/CustomEmptyList.dart';
import '../../../../Core/Custom Mades/CustomProgressIndicator.dart';
import '../../../../Core/buttons.dart';
import '../../../../Core/popup.dart';
import '../../../../Data/BLoC Manager/Debt Cubit/debt_cubit.dart';
import '../../../../Data/BLoC Manager/User Cubit/user_cubit.dart';
import 'DebtsCard.dart';
import 'SectionHeader.dart';

class DebtsList extends StatelessWidget {
  const DebtsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Debts & Credits',
          actionText: 'View All',
          onActionTap: () {
            context.push(AppRouter.seeAllDebts);
          },
        ),
        BlocBuilder<DebtCubit, DebtState>(
          builder: (context, state) {
            if (state is DebtSuccess) {
              if (state.debtsList.isEmpty) {
                return CustomEmptyList(
                  title: "No debts & credits for now",
                  buttonTitle: "Add new debt/credit",
                  onTap: () {},
                );
              }
              return Column(
                children: List.generate(
                  state.debtsList.length > 3 ? 3 : state.debtsList.length,
                  (index) => DebtsCard(
                    title: state.debtsList[index].title,
                    subtitle: state.debtsList[index].date,
                    amount: state.debtsList[index].isDebt
                        ? (state.debtsList[index].amount * -1)
                        : state.debtsList[index].amount,
                    icon: FontAwesomeIcons.moneyBill,
                    onTap: () {
                      Popup.showBottom(
                        context,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 12,
                              children: [
                                Text(
                                  '${state.debtsList[index].isDebt ? 'Debt' : 'Credit'} Details',
                                  style: AppTextStyles.headerSectionTitle,
                                ),
                                Text(
                                  'Title: ${state.debtsList[index].title}',
                                  style: AppTextStyles.listItemTitle,
                                ),
                                Text(
                                  'Date: ${state.debtsList[index].date}',
                                  style: AppTextStyles.listItemTitle,
                                ),
                                Text(
                                  'Amount: ${state.debtsList[index].amount}',
                                  style: AppTextStyles.listItemTitle,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: AppButton.sec(
                                        context,
                                        text: 'Delete',
                                        outlineColor: AppColors.redColor,
                                        onPressed: () {
                                          state.debtsList[index].delete();
                                          context
                                              .read<DebtCubit>()
                                              .fetchDebtCards();
                                          context.pop();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: AppButton.main(
                                        context,
                                        text: 'Paid Off & Delete',
                                        onPressed: () {
                                          var box =
                                              Hive.box<double>(kbalanceBox);
                                          double oldBalance =
                                              box.get(kbalanceBox) ?? 0.0;
                                          double newBalance =
                                              state.debtsList[index].isDebt
                                                  ? (oldBalance +
                                                      (state.debtsList[index]
                                                          .amount))
                                                  : (oldBalance -
                                                      (state.debtsList[index]
                                                          .amount));
                                          box.put(kbalanceBox, newBalance);
                                          state.debtsList[index].delete();
                                          context
                                              .read<UserCubit>()
                                              .fetchUserBalanceNew();
                                          context
                                              .read<DebtCubit>()
                                              .fetchDebtCards();
                                          context.pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (state is DebtFailure) {
              return Center(child: Text(state.toString()));
            } else {
              return const CustomProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
