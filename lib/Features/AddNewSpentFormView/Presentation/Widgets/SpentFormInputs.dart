import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Data/BLoC%20Manager/Add%20New%20Spent%20Cubit/add_new_spent_cubit.dart";
import "package:fundflow/Data/BLoC%20Manager/Spent%20Cubit/spent_cubit.dart";
import "package:fundflow/Data/BLoC%20Manager/User%20Cubit/user_cubit.dart";
import "package:fundflow/Data/Models/Spent%20Card%20Model/SpentCardModel.dart";
import "package:fundflow/Data/Models/Spent%20Detail%20Model/SpentDetailModel.dart";
import "package:fundflow/Features/AddNewSavingFormView/Presentation/Widgets/CustomSavingTextField.dart";
import "package:hive_flutter/hive_flutter.dart";

import "../../../../ContValues.dart";
import "../../../../Core/Custom Mades/CustomTextField.dart";
import "../../../HomeView/Presentation/Widgets/Bottom Sheets Widgets/ConfirmSlider.dart";

class SpentInputForm extends StatefulWidget {
  const SpentInputForm({super.key});

  @override
  State<SpentInputForm> createState() => _SpentInputFormState();
}

class _SpentInputFormState extends State<SpentInputForm> {
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String cardTitle = "";
  String spendTitle = "";
  double currentSpent = 0.0;
  String lastUpdate = "";
  List<SpentDetailModel> spentDetailList = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNewSpentCubit, AddNewSpentState>(
      listener: (context, state) {
        if (state is AddNewSpentSuccess) {
          BlocProvider.of<SpentCubit>(context).fetchSpentCards();
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
                title: "Category",
                onSaved: (val) {
                  cardTitle = val!;
                },
              ),
              const SizedBox(height: 20),
              CustomSavingTextField(
                isAddNew: true,
                title: "Spend Title",
                onSaved: (val) {
                  spendTitle = val!;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: CustomTextField(
                  title: "Spend Amount",
                  color: const Color.fromARGB(176, 0, 0, 0),
                  onSaved: (val) {
                    currentSpent = double.parse(val ?? "0.0");
                  },
                ),
              ),
              const SizedBox(height: 30),
              ConfirmSlider(
                action: (controller) async {
                  if (key.currentState!.validate()) {
                    key.currentState!.save();
                    Box<double> balanceBox = Hive.box<double>(kbalanceBox);
                    double currentBalance = balanceBox.get(kbalanceBox) ?? 0.0;
                    if (currentBalance >= currentSpent) {
                      lastUpdate =
                          "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}-${DateTime.now().hour}:${DateTime.now().minute}";
                      currentBalance = currentBalance - currentSpent;
                      balanceBox.put(kbalanceBox, currentBalance);
                      SpentDetailModel spentDetailModel = SpentDetailModel(
                        spendTitle,
                        "$currentSpent",
                        "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}",
                      );
                      spentDetailList.add(spentDetailModel);
                      SpentCardModel spentCardModel = SpentCardModel(
                        cardTitle,
                        currentSpent,
                        lastUpdate,
                        spentDetailList,
                      );
                      BlocProvider.of<AddNewSpentCubit>(context)
                          .addNewSpentCard(spentCardModel);
                      controller.success();
                      await Future.delayed(const Duration(milliseconds: 800));
                    } else {
                      showSnackBarMessage(false, false, context, "", "",
                          "Not enough balance to do this operation!");
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                      controller.failure();
                      await Future.delayed(const Duration(milliseconds: 800));
                      controller.reset();
                    }
                  } else {
                    showSnackBarMessage(false, false, context, "", "",
                        "Error occured. Try again, Please!");
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                    controller.failure();
                    await Future.delayed(const Duration(milliseconds: 800));
                    controller.reset();
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
