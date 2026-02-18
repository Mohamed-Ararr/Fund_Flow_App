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
