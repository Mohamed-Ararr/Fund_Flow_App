import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Data/BLoC%20Manager/Spent%20Cubit/spent_cubit.dart";
import "package:fundflow/Data/Models/Spent%20Card%20Model/SpentCardModel.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/Bottom%20Sheets%20Widgets/AddMoneySpentTrackBottomSheet.dart";

import "../../../../../../../ContValues.dart";
import "DividerAndAddNew.dart";
import "SpentHistoryListView.dart";
import "TotalSpent.dart";

class SpentHistoryMainBody extends StatelessWidget {
  const SpentHistoryMainBody({super.key, required this.spentCardModel});

  final SpentCardModel spentCardModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpentCubit, SpentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: kPaddingLR12,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  TotalSpent(
                    lastUpdate:
                        spentCardModel.lastUpdate!.split("-").toList()[0],
                    amount: spentCardModel.spentAmount!,
                  ),
                  const SizedBox(height: 5),
                  DividerAndAddNew(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: SingleChildScrollView(
                              child: AddMoneySpentTrackBottomSheet(
                                spentCardModel: spentCardModel,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SpentHistoryListView(spentCardModel: spentCardModel),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
