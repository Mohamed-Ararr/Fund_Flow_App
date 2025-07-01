import "package:flutter/material.dart";

import "../../../../ContValues.dart";
import "../../../../Core/AppColors.dart";

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, this.onChanged, this.onSaved, this.color, this.title});

  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Color? color;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: color, fontSize: 18),
      onChanged: onChanged,
      onSaved: onSaved,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          RegExp numericRegExp = RegExp(r'^\d+(\.\d+)?$');
          if (numericRegExp.hasMatch(value)) {
            if (double.parse(value) < 0.0) {
              return "Unsupported Operation!";
            } else {
              return null;
            }
          } else {
            return "Unsupported Operation!";
          }
        } else {
          return "Field required!";
        }
      },
      cursorColor: color,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        label: Text(
          title ?? "Enter the amount",
          style: TextStyle(
            color: color,
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
