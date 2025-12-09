import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/Core/helper.dart';

import '../../../ContValues.dart';
import '../../../Core/AppColors.dart';
import '../../../Data/BLoC Manager/Debt Cubit/debt_cubit.dart';
import '../../../Data/BLoC Manager/Transaction Cubit/transaction_cubit.dart';
import '../../../Data/BLoC Manager/User Cubit/user_cubit.dart';

class MonthSummary extends StatelessWidget {
  const MonthSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor.withValues(alpha: 0.5),
        // color: AppColors.lightGreyColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This Month Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 16),

          /// === Using Nested BlocBuilders for MultiBloc ===
          BlocBuilder<UserCubit, UserState>(
            builder: (context, uState) {
              return BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, txState) {
                  return BlocBuilder<DebtCubit, DebtState>(
                    builder: (context, debtState) {
                      // Calculate totals safely
                      String totalSpending = '';
                      String totalCredits = '';
                      String totalDebts = '';
                      String netBalance = '';

                      if (uState is UserSuccessNew) {
                        netBalance =
                            '${getCurrencySymbol()} ${uState.currentBalance.abs().toStringAsFixed(2)}';
                      }
                      if (txState is TransactionLoaded) {
                        totalSpending =
                            Helper.totalTransaction(txState.transactions);
                      }
                      if (debtState is DebtSuccess) {
                        totalCredits = Helper.totalCredits(debtState.debtsList);
                        totalDebts = Helper.totalDebts(debtState.debtsList);
                      }

                      return Column(
                        children: [
                          // Top row: Total Spending & Credits
                          Row(
                            children: [
                              Expanded(
                                child: _SummaryCard(
                                  title: 'Net Balance',
                                  amount: netBalance,
                                  subtitle: 'Available balance',
                                  amountColor: AppColors.blueColor,
                                  icon: Icons.show_chart,
                                  isTrendingUp: true,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _SummaryCard(
                                  title: 'Total Spending',
                                  amount: totalSpending,
                                  subtitle: '+12% from last month',
                                  amountColor: AppColors.orangeColor,
                                  icon: Icons.arrow_upward,
                                  isTrendingUp: false,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Bottom row: Debts & Net Balance
                          Row(
                            children: [
                              Expanded(
                                child: _SummaryCard(
                                  title: 'Debts',
                                  amount: totalDebts,
                                  subtitle: '+8% from last month',
                                  amountColor: AppColors.warningOrange,
                                  icon: Icons.arrow_upward,
                                  isTrendingUp: false,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _SummaryCard(
                                  title: 'Credits',
                                  amount: totalCredits,
                                  subtitle: '-3% from last month',
                                  amountColor: AppColors.successTeal,
                                  icon: Icons.arrow_downward,
                                  isTrendingUp: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String subtitle;
  final Color amountColor;
  final IconData icon;
  final bool isTrendingUp;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.amountColor,
    required this.icon,
    required this.isTrendingUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 5,
            children: [
              Icon(
                icon,
                size: 16,
                color: isTrendingUp
                    ? AppColors.successTeal
                    : AppColors.warningOrange,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              color: amountColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // Text(
          //   subtitle,
          //   style: const TextStyle(
          //     color: AppColors.greyColor,
          //     fontSize: 11,
          //     height: 1.2,
          //   ),
          // ),
        ],
      ),
    );
  }
}
