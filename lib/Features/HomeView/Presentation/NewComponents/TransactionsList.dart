import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/Core/AppColors.dart';
import 'package:fundflow/Core/AppRouter.dart';
import 'package:fundflow/Core/AppTextStyles.dart';
import 'package:fundflow/Core/Custom%20Mades/CustomEmptyList.dart';
import 'package:fundflow/Core/buttons.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../ContValues.dart';
import '../../../../Core/Custom Mades/CustomProgressIndicator.dart';
import '../../../../Core/popup.dart';
import '../../../../Data/BLoC Manager/Transaction Cubit/transaction_cubit.dart';
import '../../../../Data/BLoC Manager/User Cubit/user_cubit.dart';
import 'SectionHeader.dart';
import 'TransactionListItem.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Recent Transcations',
          actionText: 'View All',
          onActionTap: () {
            context.push(AppRouter.seeAllTransactions);
          },
        ),
        BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoaded) {
              if (state.transactions.isEmpty) {
                return const CustomEmptyList(
                  title: 'No Transactions yet',
                  buttonTitle: 'add new',
                );
              }
              return Column(
                children: List.generate(
                  state.transactions.length > 3 ? 3 : state.transactions.length,
                  (index) => TransactionListItem(
                    title: state.transactions[index].title ?? 'Unknown',
                    subtitle: state.transactions[index].desc ?? 'Unknown',
                    amount: state.transactions[index].spentAmount ?? 0.0,
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
                                const Text(
                                  'Transaction Details',
                                  style: AppTextStyles.headerSectionTitle,
                                ),
                                Text(
                                  'Title: ${state.transactions[index].title ?? 'Unknown'}',
                                  style: AppTextStyles.listItemTitle,
                                ),
                                Text(
                                  'Category: ${state.transactions[index].desc ?? 'Unknown'}',
                                  style: AppTextStyles.listItemTitle,
                                ),
                                Text(
                                  'Amount: ${state.transactions[index].spentAmount ?? 0.0}',
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
                                          state.transactions[index].delete();
                                          context
                                              .read<UserCubit>()
                                              .fetchUserBalanceNew();
                                          context
                                              .read<TransactionCubit>()
                                              .fetchTransactions();
                                          context.pop();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: AppButton.main(
                                        context,
                                        text: 'Delete & Refund',
                                        onPressed: () {
                                          var box =
                                              Hive.box<double>(kbalanceBox);
                                          double oldBalance =
                                              box.get(kbalanceBox) ?? 0.0;
                                          double newBalance = oldBalance -
                                              (state.transactions[index]
                                                      .spentAmount ??
                                                  0.0);
                                          box.put(kbalanceBox, newBalance);
                                          state.transactions[index].delete();
                                          context
                                              .read<UserCubit>()
                                              .fetchUserBalanceNew();
                                          context
                                              .read<TransactionCubit>()
                                              .fetchTransactions();
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
            } else if (state is TransactionError) {
              return Center(child: Text(state.message));
            } else {
              return const CustomProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
