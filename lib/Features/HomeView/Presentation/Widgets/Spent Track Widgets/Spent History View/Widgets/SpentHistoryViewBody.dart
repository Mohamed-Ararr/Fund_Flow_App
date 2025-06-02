import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Core/AppFonts.dart";
import "package:fundflow/Data/BLoC%20Manager/Spent%20Cubit/spent_cubit.dart";

import "../../../../../../../Core/Custom Mades/CustomDeleteButton.dart";
import "../../../../../../../Data/Models/Spent Card Model/SpentCardModel.dart";
import "SpentHistoryMainBody.dart";

class SpentHistoryViewBody extends StatelessWidget {
  const SpentHistoryViewBody({super.key, required this.spentCardModel});

  final SpentCardModel spentCardModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpentCubit, SpentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text("Spend History", style: AppFonts.font20BoldBlack),
            leading: const BackButton(color: Colors.black),
            actions: [
              CustomDeleteButton(
                onPressed: () {
                  spentCardModel.delete();
                  BlocProvider.of<SpentCubit>(context).fetchSpentCards();
                  goBackFunction(context);
                },
              ),
            ],
          ),
          body: SpentHistoryMainBody(spentCardModel: spentCardModel),
        );
      },
    );
  }
}
