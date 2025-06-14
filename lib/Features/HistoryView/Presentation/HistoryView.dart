import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Core/helper.dart';

import '../../../Core/AppColors.dart';
import '../../../Core/AppFonts.dart';
import '../../../Data/BLoC Manager/Spent Cubit/spent_cubit.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.whiteColor,
        title: const Text("History"),
      ),
      body: SingleChildScrollView(
        padding: kPadding15,
        child: Column(
          children: [
            SpentsList(),
          ],
        ),
      ),
    );
  }
}

class SpentsList extends StatelessWidget {
  const SpentsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var spents = context.watch<SpentCubit>().spentL?.reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Spents',
          style: AppTextStyles.bodyLarge(context),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: spents?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              padding: kPadding8,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                borderRadius: kBr6,
                color: AppColors.blueColor,
                // gradient: const LinearGradient(
                //   end: Alignment.topRight,
                //   begin: Alignment.bottomLeft,
                //   colors: [AppColors.blueColor, AppColors.lightBlueColor],
                // ),
              ),
              child: ListTile(
                iconColor: AppColors.orangeColor,
                leading: const Icon(
                  Icons.credit_card,
                  size: 35,
                ),
                title: Text(
                  spents?[index].spentDetailTitle ?? '',
                  style: AppFonts.font18Bold,
                ),
                subtitle: Text(
                  spents?[index].spentDetailDate ?? '',
                  style: AppFonts.font12Bold,
                ),
                trailing: Text(
                  "${Helper.formatCurrency(double.tryParse(spents?[index].spentDetailAmount ?? "0"))} ${getCurrency()}",
                  style: AppFonts.font16Bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
