import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Data/BLoC%20Manager/Add%20New%20Saving%20Cubit/add_new_saving_cubit.dart";
import "package:fundflow/Data/BLoC%20Manager/Saving%20Cubit/saving_cubit.dart";
import "package:fundflow/Data/BLoC%20Manager/User%20Cubit/user_cubit.dart";
import "package:fundflow/Data/Models/Saving%20Card%20Model/SavingCardModel.dart";
import "package:fundflow/Features/AddNewSavingFormView/Presentation/Widgets/CustomSavingTextField.dart";
import "package:hive_flutter/hive_flutter.dart";

import "../../../../ContValues.dart";
import "../../../../Core/Custom Mades/CustomTextField.dart";
import "../../../HomeView/Presentation/Widgets/Bottom Sheets Widgets/ConfirmSlider.dart";

class FormInputs extends StatefulWidget {
  const FormInputs({super.key});

  @override
  State<FormInputs> createState() => _FormInputsState();
}

class _FormInputsState extends State<FormInputs> {
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String cardTitle = "";
  double savingGoal = 0.0;
  double currentGoal = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNewSavingCubit, AddNewSavingState>(
      listener: (context, state) {
        if (state is AddNewSavingSuccess) {
          BlocProvider.of<SavingCubit>(context).fetchSavingCards();
          BlocProvider.of<UserCubit>(context).fetchUserBalance();
          goBackFunction(context);
        }
      },
      builder: (context, state) {
        return Form(
          key: key,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const SizedBox(height: 30),
              CustomSavingTextField(
                isAddNew: true,
                title: "Plan Title",
                onSaved: (val) {
                  cardTitle = val!;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                title: "Saving Goal",
                color: const Color.fromARGB(176, 0, 0, 0),
                onSaved: (val) {
                  savingGoal = double.parse(val ?? "0.0");
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                title: "Current Saving",
                color: const Color.fromARGB(176, 0, 0, 0),
                onSaved: (val) {
                  currentGoal = double.parse(val ?? "0.0");
                },
              ),
              const SizedBox(height: 30),
              ConfirmSlider(
                action: (controller) async {
                  if (key.currentState!.validate()) {
                    key.currentState!.save();
                    Box<double> balanceBox = Hive.box<double>(kbalanceBox);
                    double currentBalance = balanceBox.get(kbalanceBox) ?? 0.0;
                    if (currentGoal > savingGoal) {
                      showSnackBarMessage(
                          true,
                          true,
                          context,
                          "",
                          "Current saving can't be superior than saving goal!",
                          "");
                    } else {
                      if (currentBalance >= currentGoal) {
                        currentBalance = currentBalance - currentGoal;
                        balanceBox.put(kbalanceBox, currentBalance);
                        SavingCardModel savingCardModel = SavingCardModel(
                          title: cardTitle,
                          currentSaving: currentGoal,
                          savingGoal: savingGoal,
                          isCompleted: false,
                          createdDate:
                              "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}",
                          lastSeen:
                              "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year} - ${DateTime.now().hour}:${DateTime.now().minute}",
                        );
                        if (currentGoal == savingGoal) {
                          savingCardModel.isCompleted = true;
                        }
                        BlocProvider.of<AddNewSavingCubit>(context)
                            .addNewSavingCard(savingCardModel);
                        sliderSuccessOperation(controller);
                      } else {
                        showSnackBarMessage(false, false, context, "", "",
                            "Not enough balance to do this operation!");
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                        sliderFailureOperation(controller);
                      }
                    }
                  } else {
                    showSnackBarMessage(false, false, context, "", "",
                        "Error occured. Try again, Please!");
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                    sliderFailureOperation(controller);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
