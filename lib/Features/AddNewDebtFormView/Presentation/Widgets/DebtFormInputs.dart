import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Data/BLoC%20Manager/Add%20New%20Debt%20Cubit/add_new_debt_cubit.dart";
import "package:fundflow/Data/BLoC%20Manager/Debt%20Cubit/debt_cubit.dart";
import "package:fundflow/Data/BLoC%20Manager/User%20Cubit/user_cubit.dart";
import "package:fundflow/Data/Models/Debt%20Card%20Model/DebtCardModel.dart";
import "package:fundflow/Features/AddNewDebtFormView/Presentation/Widgets/CustomDebtDropdown.dart";
import "package:fundflow/Features/AddNewSavingFormView/Presentation/Widgets/CustomSavingTextField.dart";
import "package:hive_flutter/hive_flutter.dart";

import "../../../../ContValues.dart";
import "../../../../Core/Custom Mades/CustomTextField.dart";
import "../../../HomeView/Presentation/Widgets/Bottom Sheets Widgets/ConfirmSlider.dart";

class DebtFormInputs extends StatefulWidget {
  const DebtFormInputs({super.key});

  @override
  State<DebtFormInputs> createState() => _DebtFormInputsState();
}

class _DebtFormInputsState extends State<DebtFormInputs> {
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String cardTitle = "";
  double amount = 0.0;
  bool isDebt = true;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNewDebtCubit, AddNewDebtState>(
      listener: (context, state) {
        if (state is AddNewDebtSuccess) {
          BlocProvider.of<DebtCubit>(context).fetchDebtCards();
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
                title: "Transaction Title",
                onSaved: (val) {
                  cardTitle = val!;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                title: "Amount",
                color: const Color.fromARGB(176, 0, 0, 0),
                onSaved: (val) {
                  amount = double.parse(val!);
                },
              ),
              const SizedBox(height: 20),
              CustomDebtDropdown(
                onSaved: (val) =>
                    val == "Request a loan" ? isDebt = true : isDebt = false,
              ),
              const SizedBox(height: 30),
              ConfirmSlider(
                action: (controller) async {
                  if (key.currentState!.validate()) {
                    key.currentState!.save();
                    Box<double> balanceBox = Hive.box<double>(kbalanceBox);
                    double currentBalance = balanceBox.get(kbalanceBox)!;
                    if (isDebt) {
                      currentBalance = currentBalance + amount;
                      balanceBox.put(kbalanceBox, currentBalance);
                      DebtCardModel debtCardModel = DebtCardModel(
                        title: cardTitle,
                        amount: amount,
                        date:
                            "${date.day} ${months[date.month - 1]} ${date.year}",
                        isDebt: isDebt,
                        isPaid: false,
                      );
                      BlocProvider.of<AddNewDebtCubit>(context)
                          .addNewDebtCard(debtCardModel);
                      sliderSuccessOperation(controller);
                    } else {
                      if (currentBalance >= amount) {
                        currentBalance = currentBalance - amount;
                        balanceBox.put(kbalanceBox, currentBalance);
                        DebtCardModel debtCardModel = DebtCardModel(
                          title: cardTitle,
                          amount: amount,
                          date:
                              "${date.day} ${months[date.month - 1]} ${date.year}",
                          isDebt: isDebt,
                          isPaid: false,
                        );
                        BlocProvider.of<AddNewDebtCubit>(context)
                            .addNewDebtCard(debtCardModel);
                      } else {
                        showSnackBarMessage(false, false, context, "", "",
                            "Not enough balance to do this operation");
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
