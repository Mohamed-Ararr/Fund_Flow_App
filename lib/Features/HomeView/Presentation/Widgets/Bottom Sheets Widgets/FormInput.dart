import "package:flutter/material.dart";

import "../../../../../Core/Custom Mades/CustomTextField.dart";

class FormInput extends StatefulWidget {
  const FormInput({super.key});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  double amount = 0.0;

  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: key,
          child: Column(
            children: [
              CustomTextField(
                onSaved: (val) {
                  setState(() {
                    amount = double.parse(val ?? "0.0");
                  });
                },
              ),
            ],
          ),
        ),
        // const Spacer(),
        ElevatedButton(
          onPressed: () {
            if (key.currentState!.validate()) {
              key.currentState!.save();
            } else {}
          },
          child: const Text("here"),
        ),
      ],
    );
  }
}
