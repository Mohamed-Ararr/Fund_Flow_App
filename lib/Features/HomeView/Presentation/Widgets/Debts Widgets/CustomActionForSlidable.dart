import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_slidable/flutter_slidable.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";
import "../../../../../Core/Custom Mades/CustomButton.dart";
import "../../../../../Data/BLoC Manager/Debt Cubit/debt_cubit.dart";

class CustomActionForSlidable extends StatelessWidget {
  const CustomActionForSlidable({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (context) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: kBr10,
            ),
            title: Icon(
              Icons.warning_amber_rounded,
              color: AppColors.redColor,
              size: 40,
            ),
            content:
                const Text("Are you sure you want to delete this transaction?"),
            actions: [
              CustomButton(
                onPressed: () => goBackFunction(context),
                text: "No",
                color: AppColors.redColor,
              ),
              CustomButton(
                onPressed: onTap,
                text: "Yes",
                color: AppColors.blueColor,
              ),
            ],
          ),
        );
        BlocProvider.of<DebtCubit>(context).fetchDebtCards();
      },
      borderRadius: kBr10,
      backgroundColor: AppColors.redColor,
      foregroundColor: Colors.white,
      icon: Icons.delete_outline_outlined,
      label: 'Delete',
    );
  }
}
