import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/Features/SettingsScreen/widgets/AccountAndSecurity.dart';

import '../../Core/AppTextStyles.dart';
import 'widgets/AppSettings.dart';
import 'widgets/Preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "settings".tr(),
          style: AppTextStyles.headerSectionTitle(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _sectionTitle("preferences".tr()),
          const SizedBox(height: 10),
          const Preferences(),
          const SizedBox(height: 25),
          _sectionTitle("accountSec".tr()),
          const SizedBox(height: 10),
          const AccountAndSecurity(),
          const SizedBox(height: 25),
          _sectionTitle("appSettings".tr()),
          const SizedBox(height: 10),
          const AppSettings(),

          const SizedBox(height: 25),
          // _sectionTitle("Help & About"),
          // _SettingsCard(
          //   child: Column(
          //     children: [
          //       SettingsItem(
          //         icon: Icons.support_agent,
          //         title: "Contact Support",
          //         onTap: () {},
          //       ),
          //       const Divider(color: AppColors.dividerLight),
          //       SettingsItem(
          //         icon: Icons.privacy_tip_outlined,
          //         title: "Privacy Policy",
          //         onTap: () {},
          //       ),
          //       const Divider(color: AppColors.dividerLight),
          //       SettingsItem(
          //         icon: Icons.description_outlined,
          //         title: "Terms & Conditions",
          //         onTap: () {},
          //       ),
          //       const Divider(color: AppColors.dividerLight),
          //       SettingsItem(
          //         icon: Icons.info_outline,
          //         title: "App Version",
          //         trailing: const Text("1.0.0",
          //             style: TextStyle(color: AppColors.greyColor)),
          //         onTap: () {},
          //       ),
          //     ],
          //   ),
          // ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: AppTextStyles.headerSectionTitle(context),
    );
  }
}
