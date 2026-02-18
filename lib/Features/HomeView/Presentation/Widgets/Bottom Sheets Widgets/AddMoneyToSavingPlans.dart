import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Core/AppFonts.dart";
import "package:fundflow/Data/BLoC%20Manager/Saving%20Cubit/saving_cubit.dart";
import "package:fundflow/Data/Models/Saving%20Card%20Model/SavingCardModel.dart";
import "package:hive/hive.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";
import "../../../../../Core/Custom Mades/CustomTextField.dart";
import "../../../../../Data/BLoC Manager/User Cubit/user_cubit.dart";
import "ConfirmSlider.dart";
import "DragLineBottomSheet.dart";

class AddMoneyToSavingPlans extends StatefulWidget {
  const AddMoneyToSavingPlans({super.key, required this.savingCardModel});

  final SavingCardModel savingCardModel;

  @override
  State<AddMoneyToSavingPlans> createState() => _AddMoneyToSavingPlansState();
}

class _AddMoneyToSavingPlansState extends State<AddMoneyToSavingPlans> {
  double amount = 0.0;
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: kBrTopLR,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 30,
        children: [
          const DragLineBottomSheet(),
          Text("Top Up", style: AppFonts.font22WhiteBold),
          Form(
            key: key,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                CustomTextField(
                  color: Colors.white,
                  onSaved: (val) {
                    amount = double.tryParse(val!)!;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(),
          ConfirmSlider(
            action: (controller) async {
              if (key.currentState!.validate() && amount >= 0.0) {
                key.currentState!.save();
                Box<double> balanceBox = Hive.box<double>(kbalanceBox);
                double currentBalance = balanceBox.get(kbalanceBox) ?? 0.0;
                if (currentBalance >= amount) {
                  if ((widget.savingCardModel.currentSaving! + amount) >
                      widget.savingCardModel.savingGoal!) {
                    showSnackBarMessage(true, true, context, "",
                        "You have exceeded the saving target", "");
                  } else {
                    if ((widget.savingCardModel.currentSaving! + amount) ==
                        widget.savingCardModel.savingGoal!) {
                      showSnackBarMessage(true, false, context,
                          "You've reached the target", "", "");
                      currentBalance = currentBalance - amount;
                      widget.savingCardModel.currentSaving =
                          widget.savingCardModel.currentSaving! + amount;
                      widget.savingCardModel.isCompleted = true;
                    } else {
                      currentBalance = currentBalance - amount;

                      widget.savingCardModel.currentSaving =
                          widget.savingCardModel.currentSaving! + amount;
                    }
                    widget.savingCardModel.lastSeen =
                        "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year} - ${DateTime.now().hour}:${DateTime.now().minute}";
                    widget.savingCardModel.save();
                    balanceBox.put(kbalanceBox, currentBalance);
                    BlocProvider.of<UserCubit>(context).fetchUserBalanceNew();
                    BlocProvider.of<SavingCubit>(context).fetchSavingCards();
                    sliderSuccessOperation(controller);
                    goBackFunction(context);
                  }
                } else {
                  showSnackBarMessage(false, false, context, "", "",
                      "Not enough balance to do this operation");
                }
              } else {
                showSnackBarMessage(false, false, context, "", "",
                    "Unexpected error. Try again, Please!");
                autovalidateMode = AutovalidateMode.always;
                setState(() {});
                sliderFailureOperation(controller);
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
