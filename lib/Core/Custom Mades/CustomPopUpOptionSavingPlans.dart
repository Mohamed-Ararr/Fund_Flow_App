import "package:custom_pop_up_menu/custom_pop_up_menu.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Core/Custom%20Mades/CustomButton.dart";
import "package:fundflow/Data/BLoC%20Manager/Saving%20Cubit/saving_cubit.dart";
import "package:fundflow/Data/Models/Saving%20Card%20Model/SavingCardModel.dart";
import "package:fundflow/Features/HomeView/Presentation/Widgets/Bottom%20Sheets%20Widgets/AddMoneyToSavingPlans.dart";
import "package:go_router/go_router.dart";

import "../../../../Core/AppColors.dart";
import "../../Features/HomeView/Presentation/Widgets/Saving Plans Widgets/MultiServiceButton.dart";
import "../../Features/HomeView/Presentation/Widgets/ThreeDotsButton.dart";
import "CustomOptionRow.dart";

class CustomPopupOptionSavingPlans extends StatefulWidget {
  const CustomPopupOptionSavingPlans(
      {super.key, required this.savingCardModel});

  final SavingCardModel savingCardModel;

  @override
  State<CustomPopupOptionSavingPlans> createState() =>
      _CustomPopupOptionSavingPlansState();
}

class _CustomPopupOptionSavingPlansState
    extends State<CustomPopupOptionSavingPlans> {
  CustomPopupMenuController? controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      controller: controller,
      showArrow: false,
      menuBuilder: () => ClipRRect(
        borderRadius: kBr10,
        child: Container(
          color: AppColors.greyColor,
          child: IntrinsicWidth(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    controller!.hideMenu();
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: SingleChildScrollView(
                            child: AddMoneyToSavingPlans(
                              savingCardModel: widget.savingCardModel,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const CustomOptionRow(
                    title: "Top up",
                    iconData: Icons.add_box_outlined,
                  ),
                ),
                MultiServiceButton(
                  onTap: () {
                    controller!.hideMenu();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: kBr10,
                        ),
                        title: const Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.redColor,
                          size: 40,
                        ),
                        content: const Text(
                            "Are you sure you want to clear the balance?"),
                        actions: [
                          CustomButton(
                            onPressed: () => GoRouter.of(context).pop(),
                            text: "No",
                            color: AppColors.redColor,
                          ),
                          CustomButton(
                            onPressed: () {
                              widget.savingCardModel.currentSaving = 0.0;
                              widget.savingCardModel.isCompleted = false;
                              widget.savingCardModel.lastSeen =
                                  "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year} - ${DateTime.now().hour}:${DateTime.now().minute}";
                              BlocProvider.of<SavingCubit>(context)
                                  .fetchSavingCards();
                              goBackFunction(context);
                            },
                            text: "Yes",
                            color: AppColors.blueColor,
                          ),
                        ],
                      ),
                    );
                  },
                  title: "Clear balance",
                  icon: Icons.remove_circle_outline,
                ),
                MultiServiceButton(
                  onTap: () {
                    controller!.hideMenu();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: kBr10,
                        ),
                        // ignore: prefer_const_constructors
                        title: Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.redColor,
                          size: 40,
                        ),
                        content: const Text(
                            "Are you sure you want to delete this plan?"),
                        actions: [
                          CustomButton(
                            onPressed: () => goBackFunction(context),
                            text: "No",
                            color: AppColors.redColor,
                          ),
                          CustomButton(
                            onPressed: () {
                              widget.savingCardModel.delete();
                              BlocProvider.of<SavingCubit>(context)
                                  .fetchSavingCards();
                              goBackFunction(context);
                            },
                            text: "Yes",
                            color: AppColors.blueColor,
                          ),
                        ],
                      ),
                    );
                  },
                  title: "Delete plan",
                  icon: Icons.delete_outline,
                ),
              ],
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      child: const ThreeDotsButton(),
    );
  }
}
