import "package:flutter/material.dart";
import "package:fundflow/ContValues.dart";
import "package:fundflow/Core/AppColors.dart";

import "FormInputs.dart";

class AddNewSavingFormViewBody extends StatelessWidget {
  const AddNewSavingFormViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: const Text("Add New Plan"),
      ),
      body: Padding(
        padding: kPaddingLR12,
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: FormInputs(),
        ),
      ),
    );
  }
}
