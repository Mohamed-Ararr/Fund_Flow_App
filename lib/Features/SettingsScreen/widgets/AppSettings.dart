import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/Core/AppTextStyles.dart';
import 'package:fundflow/Core/buttons.dart';
import 'package:fundflow/Core/popup.dart';

import '../../../Core/AppColors.dart';
import '../../../Core/ToastService.dart';
import '../../../Data/BLoC Manager/Transaction Cubit/transaction_cubit.dart';
import '../../../Data/Models/TransactionExporter.dart';
import '../../../Data/Models/TransactionModel/TransactionModel.dart';
import 'ReusableComponents.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        children: [
          SettingsSwitch(
            icon: Icons.notifications_active_outlined,
            title: "Notifications",
            value: true,
            onChanged: (value) {
              ToastService.showInfo(context, 'Feature coming soon!');
            },
          ),
          const Divider(color: AppColors.dividerLight),
          SettingsItem(
            icon: Icons.cloud_upload_outlined,
            title: "Data Backup",
            onTap: () {
              ToastService.showInfo(context, 'Feature coming soon!');
            },
          ),
          const Divider(color: AppColors.dividerLight),
          SettingsItem(
            icon: Icons.file_download_outlined,
            title: "Export Transactions",
            onTap: () {
              Popup.showBottom(
                context,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 16.0,
                    ),
                    child: Column(
                      spacing: 15,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Export As',
                          style: AppTextStyles.headerSectionTitle(context),
                        ),
                        BlocBuilder<TransactionCubit, TransactionState>(
                          builder: (context, state) {
                            return Row(
                              spacing: 15,
                              children: [
                                Expanded(
                                  child: AppButton.icon(
                                    context,
                                    onPressed: () async {
                                      if (state is! TransactionLoaded) {
                                        ToastService.showError(context,
                                            'No transactions to export!');
                                        return;
                                      }
                                      final transactions = state.transactions;

                                      // Convert to model for exporter
                                      final list = transactions.map((t) {
                                        return TransactionModel(
                                          t.title ?? 'N/A',
                                          t.desc ?? 'N/A',
                                          t.spentAmount ?? 0.0,
                                          t.date ?? 'N/A',
                                        );
                                      }).toList();

                                      await TransactionExporter.exportAsPdf(
                                          list);
                                    },
                                    text: 'PDF',
                                    icon: const Icon(
                                      FontAwesomeIcons.filePdf,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: AppButton.icon(
                                    context,
                                    onPressed: () async {
                                      if (state is! TransactionLoaded) {
                                        ToastService.showError(context,
                                            'No transactions to export!');
                                        return;
                                      }
                                      final transactions = state.transactions;

                                      final list = transactions.map((t) {
                                        return TransactionModel(
                                          t.title ?? 'N/A',
                                          t.desc ?? 'N/A',
                                          t.spentAmount ?? 0.0,
                                          t.date ?? 'N/A',
                                        );
                                      }).toList();

                                      await TransactionExporter.exportAsCsv(
                                          list);
                                    },
                                    text: 'CSV',
                                    icon: const Icon(
                                      FontAwesomeIcons.fileCsv,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
