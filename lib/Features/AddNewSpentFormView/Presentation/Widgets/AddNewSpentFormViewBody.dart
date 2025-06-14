import "package:flutter/material.dart";

import "../../../../ContValues.dart";
import "../../../../Core/AppColors.dart";
import "SpentFormInputs.dart";

class AddNewSpentFormViewBody extends StatelessWidget {
  const AddNewSpentFormViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.whiteColor,
        title: const Text("Add New Category"),
      ),
      body: Padding(
        padding: kPaddingLR12,
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SpentInputForm(),
        ),
      ),
    );
  }
}
