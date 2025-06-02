import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../../../../ContValues.dart";
import "../../../../../../../Data/BLoC Manager/Spent Cubit/spent_cubit.dart";
import "../../../../../../../Data/Models/Spent Card Model/SpentCardModel.dart";
import "SpentDetailCard.dart";

class SpentHistoryListView extends StatelessWidget {
  const SpentHistoryListView({super.key, required this.spentCardModel});

  final SpentCardModel spentCardModel;

  @override
  Widget build(BuildContext context) {
    dynamic reversedList = spentCardModel.spentsList!.reversed;
    return BlocConsumer<SpentCubit, SpentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: reversedList.toList().length ?? 0,
          itemBuilder: (context, index) => Container(
            margin: kMarginTB5,
            child: SpentDetailCard(
              index: index,
              spentDetailModel: reversedList.toList()[index],
            ),
          ),
        );
      },
    );
  }
}
