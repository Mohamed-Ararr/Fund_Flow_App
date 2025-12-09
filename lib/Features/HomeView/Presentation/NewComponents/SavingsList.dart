import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/Features/HomeView/Presentation/NewComponents/SavingGoalCard.dart';

import '../../../../Core/Custom Mades/CustomEmptyList.dart';
import '../../../../Core/Custom Mades/CustomProgressIndicator.dart';
import '../../../../Data/BLoC Manager/Saving Cubit/saving_cubit.dart';
import 'SectionHeader.dart';

class SavingsList extends StatelessWidget {
  const SavingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Saving Goals',
          actionText: 'Manage',
          onActionTap: () {},
        ),
        BlocBuilder<SavingCubit, SavingState>(
          builder: (context, state) {
            if (state is SavingSuccess) {
              if (state.savingCardsList.isEmpty) {
                return CustomEmptyList(
                  title: "No saving plans for now",
                  buttonTitle: "Add new plan",
                  onTap: () {},
                );
              }
              return Column(
                children: List.generate(
                  state.savingCardsList.length > 2
                      ? 2
                      : state.savingCardsList.length,
                  (index) => SavingsGoalCard(
                    onTap: () {},
                    goalName: state.savingCardsList[index].title ?? 'Unknown',
                    currentAmount:
                        state.savingCardsList[index].currentSaving ?? 0.0,
                    targetAmount:
                        state.savingCardsList[index].savingGoal ?? 0.0,
                    icon: FontAwesomeIcons.laptop,
                  ),
                ),
              );
            } else if (state is SavingFailure) {
              return Center(child: Text(state.errorMsg));
            } else {
              return const CustomProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
