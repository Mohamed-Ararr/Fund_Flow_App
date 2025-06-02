import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Core/Custom%20Mades/CustomEmptyList.dart";
import "package:fundflow/Core/Custom%20Mades/CustomProgressIndicator.dart";
import "package:fundflow/Data/BLoC%20Manager/Spent%20Cubit/spent_cubit.dart";
import "package:go_router/go_router.dart";

import "../../../../../Core/AppRouter.dart";
import "SpentCard.dart";

class SpentGridview extends StatelessWidget {
  const SpentGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpentCubit, SpentState>(
      builder: (context, state) {
        if (state is SpentSuccess) {
          if (state.spentList.isEmpty) {
            return CustomEmptyList(
              title: "No spents for now",
              buttonTitle: "Add New Spent",
              onTap: () {
                GoRouter.of(context).push(AppRouter.addNewSpentFormView);
              },
            );
          } else {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.spentList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) => SpentCard(
                spentCardModel: state.spentList[index],
              ),
            );
          }
        } else if (state is SpentFailure) {
          return Center(child: Text(state.errorMsg));
        } else {
          return const CustomProgressIndicator();
        }
      },
    );
  }
}
