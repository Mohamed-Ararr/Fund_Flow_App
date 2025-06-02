import "package:flutter/material.dart";
import "package:fundflow/Core/AppColors.dart";
import "package:fundflow/Core/AppRouter.dart";
import "package:fundflow/Data/Models/Spent%20Card%20Model/SpentCardModel.dart";
import "package:go_router/go_router.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppFonts.dart";
import "../CardPrice.dart";
import "IconAndOption.dart";

class SpentCard extends StatelessWidget {
  const SpentCard({
    super.key,
    required this.spentCardModel,
  });

  final SpentCardModel spentCardModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(
          AppRouter.spentHistoryView,
          extra: spentCardModel,
        );
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: kBr10,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: kPadding8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconAndOption(spentCardModel: spentCardModel),
                    Text(spentCardModel.title!, style: AppFonts.font16Bold),
                    CardPrice(
                      spentCardModel: spentCardModel,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightBlueColor,
                borderRadius:
                    kBr10.copyWith(topRight: Radius.zero, topLeft: Radius.zero),
              ),
              padding: kPadding5TB10LR,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(Icons.watch_later_outlined,
                          size: 15, color: Colors.black),
                      const SizedBox(width: 3),
                      Text(spentCardModel.lastUpdate!.split("-")[0],
                          style: AppFonts.font12Bold),
                    ],
                  ),
                  Text(spentCardModel.lastUpdate!.split("-")[1],
                      style: AppFonts.font15Bold)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
