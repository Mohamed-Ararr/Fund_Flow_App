import "package:dropdown_search/dropdown_search.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Core/AppFonts.dart";
import "package:fundflow/Core/Custom%20Mades/CustomProgressIndicator.dart";
import "package:fundflow/Data/BLoC%20Manager/Spent%20Cubit/spent_cubit.dart";

import "../../ContValues.dart";
import "../AppColors.dart";

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({super.key, this.onSaved});

  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpentCubit, SpentState>(
      builder: (context, state) {
        if (state is SpentSuccess) {
          List<String> sList = [];
          state.spentList.map((spent) => sList.add(spent.title!)).toList();
          return DropdownSearch<String>(
            onSaved: onSaved,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                return null;
              } else {
                return "Field required!";
              }
            },
            dropdownButtonProps: const DropdownButtonProps(
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              iconSize: 35,
            ),
            popupProps: PopupProps.dialog(
              dialogProps: DialogProps(
                backgroundColor: AppColors.lightGreyColor,
              ),
              showSelectedItems: true,
              fit: FlexFit.loose,
            ),
            items: sList,
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: AppFonts.font18BoldWhite,
              dropdownSearchDecoration: InputDecoration(
                label: const Text(
                  "Transfer to",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.orangeColor,
                  ),
                  borderRadius: kBr10,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.orangeColor,
                  ),
                  borderRadius: kBr10,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: kBr10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black38,
                  ),
                  borderRadius: kBr10,
                ),
              ),
            ),
          );
        } else if (state is SpentFailure) {
          return const Center(child: Text("Unexpected Error"));
        } else {
          return const CustomProgressIndicator();
        }
      },
    );
  }
}
