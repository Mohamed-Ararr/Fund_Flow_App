import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Core/AppFonts.dart";
import "package:fundflow/Data/BLoC%20Manager/Spent%20Cubit/spent_cubit.dart";
import "package:fundflow/Data/Models/Spent%20Detail%20Model/SpentDetailModel.dart";
import "package:hive/hive.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";
import "../../../../../Core/Custom Mades/CustomTextField.dart";
import "../../../../../Data/BLoC Manager/User Cubit/user_cubit.dart";
import "../../../../../Data/Models/Spent Card Model/SpentCardModel.dart";
import "../../../../AddNewSavingFormView/Presentation/Widgets/CustomSavingTextField.dart";
import "ConfirmSlider.dart";
import "DragLineBottomSheet.dart";

class AddMoneySpentTrackBottomSheet extends StatefulWidget {
  const AddMoneySpentTrackBottomSheet(
      {super.key, required this.spentCardModel});

  final SpentCardModel spentCardModel;

  @override
  State<AddMoneySpentTrackBottomSheet> createState() =>
      _AddMoneySpentTrackBottomSheetState();
}

class _AddMoneySpentTrackBottomSheetState
    extends State<AddMoneySpentTrackBottomSheet> {
  double amount = 0.0;
  String spendTitle = "";
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpentCubit, SpentState>(
      listener: (context, state) {
        if (state is SpentSuccess) {}
      },
      builder: (context, state) {
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
                    var totalBalanceBox = Hive.box<double>(kbalanceBox);
                    double currentBalance =
                        totalBalanceBox.get(kbalanceBox) ?? 0.0;
                    double isValid = currentBalance - amount;
                    if (isValid < 0.0) {
                      showSnackBarMessage(false, false, context, "", "",
                          "Not enough balance to do this operation!");
                      sliderFailureOperation(controller);
                    } else {
                      widget.spentCardModel.spentAmount =
                          widget.spentCardModel.spentAmount! + amount;
                      widget.spentCardModel.lastUpdate =
                          "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}-${DateTime.now().hour}:${DateTime.now().minute}";
                      SpentDetailModel spentDetailModel = SpentDetailModel(
                        spendTitle,
                        "$amount",
                        "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}",
                      );
                      widget.spentCardModel.spentsList?.add(spentDetailModel);
                      widget.spentCardModel.save();
                      currentBalance = currentBalance - amount;
                      totalBalanceBox.put(kbalanceBox, currentBalance);
                      BlocProvider.of<UserCubit>(context).fetchUserBalance();
                      BlocProvider.of<SpentCubit>(context).fetchSpentCards();
                      sliderSuccessOperation(controller);
                      goBackFunction(context);
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
      },
    );
  }
}
