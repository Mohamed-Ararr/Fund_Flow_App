import "package:flutter/material.dart";

import "../../../../../Core/AppColors.dart";
import "../../../../../Core/Custom Mades/CustomBalanceButton.dart";
import "../Bottom Sheets Widgets/TransferMoneyBottomSheet.dart";
import '../Bottom Sheets Widgets/ChangeBalanceBottomSheet.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 40,
          child: CustomBalanceButton(
            onPressed: () {
              showBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return const ChangeBalanceBottomSheet();
                  });
            },
            backgroundColor: AppColors.orangeColor,
            text: "Top up",
          ),
        ),
        SizedBox(
          height: 40,
          child: CustomBalanceButton(
            onPressed: () {
              showBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return const TransferMoneyBottomSheet();
                  });
            },
            backgroundColor: AppColors.greyColor,
            text: "Transfer",
          ),
        ),
      ],
    );
  }
}
