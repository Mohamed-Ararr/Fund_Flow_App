import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:fundflow/Core/Custom%20Mades/CustomEmptyList.dart";
import "package:fundflow/Core/Custom%20Mades/CustomProgressIndicator.dart";
import "package:fundflow/Data/BLoC%20Manager/Debt%20Cubit/debt_cubit.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/Debts%20Widgets/CustomActionForSlidable.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/Debts%20Widgets/DebtCurrentState.dart";
import "package:go_router/go_router.dart";

import "../../../../../Core/AppColors.dart";
import "DebtCard.dart";

class DebtsGridview extends StatelessWidget {
  const DebtsGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtCubit, DebtState>(
      builder: (context, state) {
        if (state is DebtSuccess) {
          if (state.debtsList.isEmpty) {
            return CustomEmptyList(
              title: "No debts & credits for now",
              buttonTitle: "Add new debt/credit",
              onTap: () =>
                  GoRouter.of(context).push(AppRouter.addNewDebtFormView),
            );
          } else {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.debtsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) => Slidable(
                startActionPane: ActionPane(
                  extentRatio: 0.3,
                  motion: const ScrollMotion(),
                  children: [
                    CustomActionForSlidable(
                      onTap: () {
                        state.debtsList[index].delete();
                        BlocProvider.of<DebtCubit>(context).fetchDebtCards();
                        goBackFunction(context);
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.topRight,
                            begin: Alignment.bottomLeft,
                            colors: state.debtsList[index].isDebt
                                ? [
                                    AppColors.blueColor,
                                    AppColors.lightBlueColor,
                                  ]
                                : [
                                    AppColors.darkOrangeColor,
                                    AppColors.lightOrangeColor,
                                  ],
                          ),
                          borderRadius: kBr10,
                        ),
                        child: DebtCard(debtCardModel: state.debtsList[index]),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DebtCurrentState(debtCardModel: state.debtsList[index]),
                  ],
                ),
              ),
            );
          }
        } else if (state is DebtFailure) {
          return Center(child: Text(state.toString()));
        } else {
          return const CustomProgressIndicator();
        }
      },
    );
  }
}
