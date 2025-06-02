import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Core/AppFonts.dart";
import "package:fundflow/Core/Custom%20Mades/CustomDropdown.dart";
import "package:fundflow/Core/Custom%20Mades/CustomProgressIndicator.dart";
import "package:fundflow/Data/BLoC%20Manager/Spent%20Cubit/spent_cubit.dart";
import "package:fundflow/Data/BLoC%20Manager/User%20Cubit/user_cubit.dart";
import "package:hive_flutter/hive_flutter.dart";

import "../../../../../Data/Models/Spent Detail Model/SpentDetailModel.dart";
import "../../../../AddNewSavingFormView/Presentation/Widgets/CustomSavingTextField.dart";
import "../../../../../Core/AppColors.dart";
import "../../../../../Core/Custom Mades/CustomTextField.dart";
import "ConfirmSlider.dart";
import "DragLineBottomSheet.dart";
import "../../../../../ContValues.dart";

class TransferMoneyBottomSheet extends StatefulWidget {
  const TransferMoneyBottomSheet({super.key});

  @override
  State<TransferMoneyBottomSheet> createState() =>
      _TransferMoneyBottomSheetState();
}

class _TransferMoneyBottomSheetState extends State<TransferMoneyBottomSheet> {
  double addedAmount = 0.0;
  String spendTitle = "";
  String? transferTo;
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  List<String> transferList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpentCubit, SpentState>(
      builder: (context, state) {
        if (state is SpentSuccess) {
          for (int i = 0; i < state.spentList.length; i++) {
            transferList.add(state.spentList[i].title!);
          }
          return Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: kBrTopLR,
            ),
            child: Column(
              children: [
                const DragLineBottomSheet(),
                const SizedBox(height: 30),
                Text("Transfer to exisiting category",
                    style: AppFonts.font22WhiteBold),
                const Spacer(),
                Form(
                  key: key,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    children: [
                      CustomDropdown(
                        onSaved: (val) {
                          transferTo = val;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomSavingTextField(
                        color: Colors.white,
                        isAddNew: false,
                        title: "Spend Title",
                        onSaved: (val) {
                          spendTitle = val!;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        color: Colors.white,
                        onSaved: (val) {
                          addedAmount = double.parse(val!);
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ConfirmSlider(
                  action: (controller) async {
                    if (key.currentState!.validate()) {
                      key.currentState!.save();
                      // -------------------------
                      // RETRIEVE THE TOTAL BALANCE
                      Box<double> balanceBox = Hive.box<double>(kbalanceBox);
                      double currentBalance =
                          balanceBox.get(kbalanceBox) ?? 0.0;
                      state.spentList.any((spent) {
                        if (spent.title == transferTo) {
                          if (currentBalance >= addedAmount) {
                            currentBalance = currentBalance - addedAmount;
                            balanceBox.put(kbalanceBox, currentBalance);
                            spent.spentAmount =
                                spent.spentAmount! + addedAmount;
                            spent.lastUpdate =
                                "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}-${DateTime.now().hour}:${DateTime.now().minute}";
                            SpentDetailModel spentDetailModel =
                                SpentDetailModel(
                              spendTitle,
                              "$addedAmount",
                              "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}",
                            );
                            spent.spentsList?.add(spentDetailModel);
                            spent.save();
                            BlocProvider.of<UserCubit>(context)
                                .fetchUserBalance();
                            BlocProvider.of<SpentCubit>(context)
                                .fetchSpentCards();

                            goBackFunction(context);
                          } else {
                            showSnackBarMessage(false, false, context, "", "",
                                "Not enough balance to do this operation!");
                            controller.reset();
                          }
                          return true;
                        } else {
                          return false;
                        }
                      });
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                      controller.failure();
                      await Future.delayed(const Duration(seconds: 1));
                      controller.reset();
                    }
                  },
                ),
                const Spacer(),
              ],
            ),
          );
        } else {
          return const CustomProgressIndicator();
        }
      },
    );
  }
}
