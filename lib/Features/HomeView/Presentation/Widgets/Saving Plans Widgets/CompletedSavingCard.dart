import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Data/BLoC%20Manager/Saving%20Cubit/saving_cubit.dart";
import "package:fundflow/Data/Models/Saving%20Card%20Model/SavingCardModel.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";

class CompletedSavingCard extends StatelessWidget {
  const CompletedSavingCard({super.key, required this.savingCardModel});

  final SavingCardModel savingCardModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              savingCardModel.isCompleted = !savingCardModel.isCompleted!;
              savingCardModel.save();
              BlocProvider.of<SavingCubit>(context).fetchSavingCards();
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
                  savingCardModel.isCompleted! ? "Completed" : "Not yet",
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
