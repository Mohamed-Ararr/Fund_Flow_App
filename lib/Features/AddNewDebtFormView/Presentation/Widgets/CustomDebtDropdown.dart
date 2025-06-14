import "package:dropdown_search/dropdown_search.dart";
import "package:flutter/material.dart";

import "../../../../ContValues.dart";
import "../../../../Core/AppColors.dart";
import "../../../../Core/AppFonts.dart";

class CustomDebtDropdown extends StatelessWidget {
  const CustomDebtDropdown({super.key, this.onSaved});

  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      onSaved: onSaved,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        } else {
          return "Field required!";
        }
      },
      items: const ["Request a loan", "Lending transaction"],
      dropdownButtonProps: const DropdownButtonProps(
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        iconSize: 35,
      ),
      popupProps: const PopupProps.menu(
        menuProps: MenuProps(
          backgroundColor: Colors.white,
        ),
        showSelectedItems: true,
        fit: FlexFit.loose,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: const TextStyle(fontSize: 18),
        dropdownSearchDecoration: InputDecoration(
          label: Text(
            "Transaction Type",
            style: AppFonts.font18Bold
                .copyWith(color: const Color.fromARGB(185, 0, 0, 0)),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.orangeColor,
            ),
            borderRadius: kBr10,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
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
  }
}
