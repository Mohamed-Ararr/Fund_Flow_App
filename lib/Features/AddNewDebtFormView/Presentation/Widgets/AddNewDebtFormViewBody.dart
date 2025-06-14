import "package:flutter/material.dart";

import "../../../../ContValues.dart";
import "../../../../Core/AppColors.dart";
import "DebtFormInputs.dart";

class AddNewDebtFormViewBody extends StatelessWidget {
  const AddNewDebtFormViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.whiteColor,
        title: const Text("Add New Debt"),
      ),
      body: Padding(
        padding: kPaddingLR12,
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: DebtFormInputs(),
        ),
      ),
    );
  }
}
