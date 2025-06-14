import "package:custom_pop_up_menu/custom_pop_up_menu.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Core/Custom%20Mades/CustomButton.dart";
import "package:fundflow/Data/BLoC%20Manager/Spent%20Cubit/spent_cubit.dart";
import "package:go_router/go_router.dart";

import "../../../../Core/AppColors.dart";
import "../../Data/Models/Spent Card Model/SpentCardModel.dart";
import "../../Features/HomeView/Presentation/Widgets/Bottom Sheets Widgets/AddMoneySpentTrackBottomSheet.dart";
import "../../Features/HomeView/Presentation/Widgets/Saving Plans Widgets/MultiServiceButton.dart";
import "../../Features/HomeView/Presentation/Widgets/ThreeDotsButton.dart";
import "CustomOptionRow.dart";

class CustomPopupOptions extends StatefulWidget {
  const CustomPopupOptions({super.key, required this.spentCardModel});

  final SpentCardModel spentCardModel;

  @override
  State<CustomPopupOptions> createState() => _CustomPopupOptionsState();
}

class _CustomPopupOptionsState extends State<CustomPopupOptions> {
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
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddMoneySpentTrackBottomSheet(
                          spentCardModel: widget.spentCardModel),
                    );
                  },
                  child: const CustomOptionRow(
                    title: "Top up",
                    iconData: Icons.add_box_outlined,
                  ),
                ),
                InkWell(
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
                              widget.spentCardModel.spentAmount = 0.0;
                              widget.spentCardModel.lastUpdate =
                                  "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}";
                              widget.spentCardModel.save();
                              BlocProvider.of<SpentCubit>(context)
                                  .fetchSpentCards();
                              goBackFunction(context);
                            },
                            text: "Yes",
                            color: AppColors.blueColor,
                          ),
                        ],
                      ),
                    );
                  },
                  child: const CustomOptionRow(
                    title: "Clear balance",
                    iconData: Icons.remove_circle_outline,
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
                            "Are you sure you want to delete this category?"),
                        actions: [
                          CustomButton(
                            onPressed: () => goBackFunction(context),
                            text: "No",
                            color: AppColors.redColor,
                          ),
                          CustomButton(
                            onPressed: () {
                              widget.spentCardModel.delete();
                              BlocProvider.of<SpentCubit>(context)
                                  .fetchSpentCards();
                              goBackFunction(context);
                            },
                            text: "Yes",
                            color: AppColors.blueColor,
                          ),
                        ],
                      ),
                    );
                  },
                  title: "Delete category",
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
