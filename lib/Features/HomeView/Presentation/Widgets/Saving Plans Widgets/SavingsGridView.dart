import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Core/Custom%20Mades/CustomEmptyList.dart";
import "package:fundflow/Data/BLoC%20Manager/Saving%20Cubit/saving_cubit.dart";
import "package:go_router/go_router.dart";

import "../../../../../Core/AppRouter.dart";
import "../../../../../Core/Custom Mades/CustomProgressIndicator.dart";
import "SavingsCard.dart";

class SavingsGridview extends StatelessWidget {
  const SavingsGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavingCubit, SavingState>(
      builder: (context, state) {
        if (state is SavingSuccess) {
          if (state.savingCardsList.isEmpty) {
            return CustomEmptyList(
              title: "No saving plans for now",
              buttonTitle: "Add new plan",
              onTap: () {
                GoRouter.of(context).push(AppRouter.addNewSavingFormView);
              },
            );
          } else {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.savingCardsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.8,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) => SavingsCard(
                index: index,
                savingCardModel: state.savingCardsList[index],
              ),
            );
          }
        } else if (state is SavingFailure) {
          return Center(child: Text(state.errorMsg));
        } else {
          return const CustomProgressIndicator();
        }
      },
    );
  }
}
