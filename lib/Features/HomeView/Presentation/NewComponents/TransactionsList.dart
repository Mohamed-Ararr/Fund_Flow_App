import 'package:easy_localization/easy_localization.dart';
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
import '../../../../Core/helper.dart';
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
          title: "recentTrans".tr(),
          actionText: 'viewAll'.tr(),
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
                  (index) {
                    final transaction = state.transactions[index];

                    return TransactionListItem(
                      title: transaction.title ?? 'Unknown',
                      subtitle: Helper.translateCategory(
                          transaction.desc), // ✅ Translate category
                      amount: transaction.spentAmount ?? 0.0,
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
                                    "transDetails".tr(),
                                    style: AppTextStyles.headerSectionTitle(
                                        context),
                                  ),
                                  Text(
                                    '${"title".tr()}: ${transaction.title ?? 'Unknown'}',
                                    style: AppTextStyles.listItemTitle(context),
                                  ),
                                  Text(
                                    '${"category".tr()}: ${Helper.translateCategory(transaction.desc)}', // ✅ Translate category
                                    style: AppTextStyles.listItemTitle(context),
                                  ),
                                  Text(
                                    '${"amount".tr()}: ${transaction.spentAmount ?? 0.0}',
                                    style: AppTextStyles.listItemTitle(context),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Expanded(
                                        child: AppButton.sec(
                                          context,
                                          text: 'delete'.tr(),
                                          outlineColor: AppColors.redColor,
                                          onPressed: () {
                                            transaction.delete();
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
                                          text: "deleteRefund".tr(),
                                          onPressed: () {
                                            var box =
                                                Hive.box<double>(kbalanceBox);
                                            double oldBalance =
                                                box.get(kbalanceBox) ?? 0.0;
                                            double newBalance = oldBalance -
                                                (transaction.spentAmount ??
                                                    0.0);
                                            box.put(kbalanceBox, newBalance);
                                            transaction.delete();
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
                    );
                  },
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
