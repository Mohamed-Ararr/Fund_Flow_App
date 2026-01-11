import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Core/helper.dart';

import '../../../Core/AppColors.dart';
import '../../../Core/AppTextStyles.dart';
import '../../../Data/BLoC Manager/Debt Cubit/debt_cubit.dart';

class DebtCreditsSummary extends StatelessWidget {
  const DebtCreditsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DebtCubit, DebtState>(
      builder: (context, state) {
        if (state is DebtLoading || state is DebtInitial) {
          return Row(
            children: [
              Expanded(
                child: _DetailSummaryCard(
                  title: 'debts'.tr(),
                  totalAmount: '-${getCurrencySymbol()} 0.00',
                  mainColor: AppColors.redColor,
                  icon: Icons.arrow_upward,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _DetailSummaryCard(
                  title: 'credits'.tr(),
                  totalAmount: '${getCurrencySymbol()} 0.00',
                  mainColor: AppColors.successTeal,
                  icon: Icons.arrow_downward,
                ),
              ),
            ],
          );
        }

        if (state is DebtFailure) {
          return const SizedBox(); // or error UI
        }

        if (state is DebtSuccess) {
          final debts = state.debtsList;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'debtSummary'.tr(),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _DetailSummaryCard(
                      title: 'debts'.tr(),
                      totalAmount: Helper.totalDebts(debts),
                      mainColor: AppColors.darkOrangeColor,
                      icon: Icons.arrow_upward,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DetailSummaryCard(
                      title: 'credits'.tr(),
                      totalAmount: Helper.totalCredits(debts),
                      mainColor: AppColors.blueColor,
                      icon: Icons.arrow_downward,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _DetailSummaryCard extends StatelessWidget {
  final String title;
  final String totalAmount;
  final Color mainColor;
  final IconData icon;

  const _DetailSummaryCard({
    required this.title,
    required this.totalAmount,
    required this.mainColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: mainColor),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Tooltip(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(minHeight: 40),
            preferBelow: false,
            textStyle: AppTextStyles.listItemTitle(context).copyWith(
              color: AppColors.whiteColor,
            ),
            triggerMode: TooltipTriggerMode.tap,
            message: totalAmount, // full value
            child: Text(
              totalAmount,
              // compactAmount,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: mainColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 1,
              backgroundColor:
                  AppColors.lightGreyColor.withValues(alpha: 0.5), // Darker bg
              valueColor: AlwaysStoppedAnimation<Color>(mainColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
