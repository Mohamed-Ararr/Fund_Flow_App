import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Features/HomeView/Presentation/NewComponents/TransactionListItem.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../Core/AppColors.dart';
import '../../Core/AppTextStyles.dart';
import '../../Core/Custom Mades/CustomEmptyList.dart';
import '../../Core/Custom Mades/CustomProgressIndicator.dart';
import '../../Core/buttons.dart';
import '../../Core/popup.dart';
import '../../Data/BLoC Manager/Transaction Cubit/transaction_cubit.dart';
import '../../Data/BLoC Manager/User Cubit/user_cubit.dart';
import '../../Data/Models/TransactionModel/TransactionModel.dart';

class SeeAllTransactions extends StatelessWidget {
  const SeeAllTransactions({super.key});

  totalTransaction(List<TransactionModel>? transactions) {
    if (transactions == null || transactions.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var transaction in transactions) {
      total += transaction.spentAmount ?? 0.0;
    }
    final String formattedAmount =
        '-${getCurrencySymbol()} ${total.abs().toStringAsFixed(2)}';
    return formattedAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions History',
          style: AppTextStyles.headerSectionTitle,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoaded) {
              if (state.transactions.isEmpty) {
                return const CustomEmptyList(
                  title: 'No Transactions yet',
                  buttonTitle: 'add new',
                );
              }
              return Column(
                spacing: 15,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      spacing: 10,
                      children: [
                        const Text(
                          'Total Spent',
                          style: AppTextStyles.headerSectionTitle,
                        ),
                        const Expanded(
                            child: Divider(
                          color: AppColors.lightGreyColor,
                        )),
                        Text(
                          '${totalTransaction(state.transactions)} ',
                          style: AppTextStyles.headerSectionTitle,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => TransactionListItem(
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
                                      'Description: ${state.transactions[index].desc ?? 'Unknown'}',
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
                                              state.transactions[index]
                                                  .delete();
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
                                              state.transactions[index]
                                                  .delete();
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
                      separatorBuilder: (_, index) => const SizedBox(height: 5),
                      itemCount: state.transactions.length,
                    ),
                  ),
                ],
              );
            } else if (state is TransactionError) {
              return Center(child: Text(state.message));
            } else {
              return const CustomProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
