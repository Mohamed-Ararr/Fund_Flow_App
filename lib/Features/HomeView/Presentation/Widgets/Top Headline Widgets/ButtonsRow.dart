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
      spacing: 15,
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: CustomBalanceButton(
              onPressed: () {
                showModalBottomSheet(
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
        ),
        Expanded(
          child: SizedBox(
            height: 40,
            child: CustomBalanceButton(
              onPressed: () {
                showModalBottomSheet(
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
        ),
      ],
    );
  }
}
