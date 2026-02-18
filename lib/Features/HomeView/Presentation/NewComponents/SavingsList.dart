import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/Core/AppRouter.dart';
import 'package:fundflow/Features/HomeView/Presentation/NewComponents/SavingGoalCard.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/AppColors.dart';
import '../../../../Core/AppTextStyles.dart';
import '../../../../Core/Custom Mades/CustomEmptyList.dart';
import '../../../../Core/Custom Mades/CustomProgressIndicator.dart';
import '../../../../Core/buttons.dart';
import '../../../../Core/popup.dart';
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
          onActionTap: () {
            context.push(AppRouter.addNewSavingFormView);
          },
        ),
        BlocBuilder<SavingCubit, SavingState>(
          builder: (context, state) {
            if (state is SavingSuccess) {
              if (state.savingCardsList.isEmpty) {
                return CustomEmptyList(
                  title: "No saving plans for now",
                  buttonTitle: "Add new plan",
                  onTap: () {
                    context.push(AppRouter.addNewSavingFormView);
                  },
                );
              }
              return Column(
                children: List.generate(
                  state.savingCardsList.length > 2
                      ? 2
                      : state.savingCardsList.length,
                  (index) => SavingsGoalCard(
                    goalName: state.savingCardsList[index].title ?? 'Unknown',
                    currentAmount:
                        state.savingCardsList[index].currentSaving ?? 0.0,
                    targetAmount:
                        state.savingCardsList[index].savingGoal ?? 0.0,
                    icon: FontAwesomeIcons.piggyBank,
                    onTap: () {
                      final goal = state.savingCardsList[index];
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
                                  'Saving Goal Details',
                                  style:
                                      AppTextStyles.headerSectionTitle(context),
                                ),
                                Text(
                                  '${"title".tr()}: ${goal.title ?? ''}',
                                  style: AppTextStyles.listItemTitle(context),
                                ),
                                Text(
                                  'Target: ${goal.savingGoal ?? 0.0}',
                                  style: AppTextStyles.listItemTitle(context),
                                ),
                                Text(
                                  'Saved: ${goal.currentSaving ?? 0.0}',
                                  style: AppTextStyles.listItemTitle(context),
                                ),
                                Text(
                                  'Status: ${(goal.isCompleted ?? false) ? "Completed" : "In Progress"}',
                                  style: AppTextStyles.listItemTitle(context),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: AppButton.sec(
                                        context,
                                        text: "delete".tr(),
                                        outlineColor: AppColors.redColor,
                                        onPressed: () {
                                          goal.delete();
                                          context
                                              .read<SavingCubit>()
                                              .fetchSavingCards();
                                          context.pop();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: AppButton.main(
                                        context,
                                        text: 'Add Money',
                                        onPressed: () {
                                          context.pop();
                                          context.push(
                                            AppRouter.logNewEntry,
                                            extra: goal,
                                          );
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
