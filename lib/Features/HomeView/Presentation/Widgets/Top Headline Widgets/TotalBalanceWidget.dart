import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Core/helper.dart";
import "package:fundflow/Data/BLoC%20Manager/User%20Cubit/user_cubit.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";
import "../../../../../Core/AppFonts.dart";

class TotalBalanceWidget extends StatefulWidget {
  const TotalBalanceWidget({super.key});

  @override
  State<TotalBalanceWidget> createState() => _TotalBalanceWidgetState();
}

class _TotalBalanceWidgetState extends State<TotalBalanceWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Balance",
                style: AppTextStyles.bodyLarge(context).copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              Text(
                "${Helper.formatCurrency(state.currentBalance)} ${getCurrency()}",
                style: AppTextStyles.headline1(context).copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              // Text(
              //   "Current balance",
              //   style: AppFonts.userWelcomeStyle16,
              // ),
              // const SizedBox(height: 5),
              // Row(
              //   // crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Text(
              //       state.currentBalance.toStringAsFixed(2),
              //       style: AppFonts.userNameStyle18.copyWith(fontSize: 25),
              //     ),
              //     const SizedBox(width: 5),
              //     Text(
              //       getCurrency(),
              //       style: AppFonts.userWelcomeStyle16.copyWith(fontSize: 12),
              //     ),
              //   ],
              // ),
            ],
          );
        } else if (state is UserFailure) {
          return Text(state.errorMsg);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
