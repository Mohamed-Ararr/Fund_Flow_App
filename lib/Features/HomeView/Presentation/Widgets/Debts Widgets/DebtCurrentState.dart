import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Data/BLoC%20Manager/Debt%20Cubit/debt_cubit.dart";
import "package:fundflow/Data/Models/Debt%20Card%20Model/DebtCardModel.dart";
import "package:hive_flutter/hive_flutter.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";
import "../../../../../Data/BLoC Manager/User Cubit/user_cubit.dart";

class DebtCurrentState extends StatelessWidget {
  const DebtCurrentState({super.key, required this.debtCardModel});

  final DebtCardModel debtCardModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Box<double> balanceBox = Hive.box<double>(kbalanceBox);
              double currentBalance = balanceBox.get(kbalanceBox) ?? 0.0;
              debtCardModel.isPaid = !(debtCardModel.isPaid ?? false);
              debtCardModel.save();
              if (debtCardModel.isPaid ?? false) {
                if (debtCardModel.isDebt) {
                  currentBalance = currentBalance - debtCardModel.amount;
                  balanceBox.put(kbalanceBox, currentBalance);
                } else {
                  currentBalance = currentBalance + debtCardModel.amount;
                  balanceBox.put(kbalanceBox, currentBalance);
                }
              } else {
                if (debtCardModel.isDebt) {
                  currentBalance = currentBalance + debtCardModel.amount;
                  balanceBox.put(kbalanceBox, currentBalance);
                } else {
                  currentBalance = currentBalance - debtCardModel.amount;
                  balanceBox.put(kbalanceBox, currentBalance);
                }
              }
              BlocProvider.of<DebtCubit>(context).fetchDebtCards();
              BlocProvider.of<UserCubit>(context).fetchUserBalanceNew();
            },
            child: RotatedBox(
              quarterTurns: 3,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.lightBlueColor,
                  borderRadius: kBr10,
                ),
                child: Text(
                  (debtCardModel.isPaid ?? false) ? "Paid" : "Not paid",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
