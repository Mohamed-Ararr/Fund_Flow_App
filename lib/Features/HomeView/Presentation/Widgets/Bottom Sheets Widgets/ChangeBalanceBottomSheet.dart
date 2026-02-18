import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Core/AppFonts.dart";
import "package:fundflow/Data/BLoC%20Manager/User%20Cubit/user_cubit.dart";
import "package:go_router/go_router.dart";
import "package:hive_flutter/adapters.dart";

import "../../../../../Core/AppColors.dart";
import "../../../../../Core/Custom Mades/CustomTextField.dart";
import "ConfirmSlider.dart";
import "DragLineBottomSheet.dart";

class ChangeBalanceBottomSheet extends StatefulWidget {
  const ChangeBalanceBottomSheet({super.key});

  @override
  State<ChangeBalanceBottomSheet> createState() =>
      _ChangeBalanceBottomSheetState();
}

class _ChangeBalanceBottomSheetState extends State<ChangeBalanceBottomSheet> {
  double addedAmount = 0.0;
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  goBackFunction() {
    GoRouter.of(context).pop();
  }

  changeBalanceFunction() {
    var box = Hive.box<double>(kbalanceBox);
    // RETRIEVE THE OLD BALANCE
    double oldBalance = box.get(kbalanceBox) ?? 0.0;
    // THEN ADD THE NEW AMOUNT TO THE OLD BALANCE
    double newBalance = oldBalance + addedAmount;
    box.put(kbalanceBox, newBalance);
    BlocProvider.of<UserCubit>(context).fetchUserBalanceNew();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      // height: MediaQuery.of(context).size.height * 0.5,
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
          Text("Top Up Balance", style: AppFonts.font22WhiteBold),
          Form(
            key: key,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                CustomTextField(
                  color: Colors.white,
                  onSaved: (val) {
                    addedAmount = double.parse(val!);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(),
          ConfirmSlider(
            action: (controller) async {
              if (key.currentState!.validate()) {
                key.currentState!.save();
                changeBalanceFunction();
                controller.success();

                showSnackBarMessage(true, false, context,
                    "Balance changed successfully", "", "");
                goBackFunction();
                controller.reset();
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
