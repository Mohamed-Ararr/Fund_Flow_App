import "package:flutter/material.dart";

import "../../../../ContValues.dart";
import "../../../../Core/AppColors.dart";

class CustomSavingTextField extends StatelessWidget {
  const CustomSavingTextField({
    super.key,
    this.onChanged,
    this.onSaved,
    required this.title,
    required this.isAddNew,
    this.color,
  });

  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String title;
  final bool isAddNew;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: color ?? Colors.black, fontSize: 18),
      onChanged: onChanged,
      onSaved: onSaved,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        } else {
          return "Field required!";
        }
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        label: Text(
          title,
          style: TextStyle(
            color: isAddNew ? const Color.fromARGB(176, 0, 0, 0) : Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
    );
  }
}
