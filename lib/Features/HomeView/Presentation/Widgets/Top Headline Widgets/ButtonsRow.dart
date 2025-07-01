import "package:flutter/material.dart";
import "package:fundflow/Core/buttons.dart";

import "../../../../../Core/AppColors.dart";
import '../Bottom Sheets Widgets/ChangeBalanceBottomSheet.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        Expanded(
          child: AppButton.main(
            context,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: const SingleChildScrollView(
                      child: ChangeBalanceBottomSheet(),
                    ),
                  );
                },
              );
            },
            backgroundColor: AppColors.orangeColor,
            text: "Top up",
          ),
        ),
        // Expanded(
        //   child: AppButton.sec(
        //     context,
        //     onPressed: () {
        //       showModalBottomSheet(
        //           context: context,
        //           backgroundColor: Colors.transparent,
        //           builder: (context) {
        //             return const TransferMoneyBottomSheet();
        //           });
        //     },
        //     backgroundColor: AppColors.orangeColor,
        //     textColor: AppColors.orangeColor,
        //     text: "History",
        //   ),
        // ),
      ],
    );
  }
}
