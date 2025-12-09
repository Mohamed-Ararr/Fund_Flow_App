import 'package:flutter/material.dart';
import 'package:fundflow/Core/ToastService.dart';
import 'package:fundflow/Features/SettingsScreen/widgets/ReusableComponents.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Core/AppColors.dart';

class AccountAndSecurity extends StatefulWidget {
  const AccountAndSecurity({super.key});

  @override
  State<AccountAndSecurity> createState() => _AccountAndSecurityState();
}

class _AccountAndSecurityState extends State<AccountAndSecurity> {
  bool biometricsEnabled = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      biometricsEnabled = prefs.getBool("biometrics_enabled") ?? false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        children: [
          SettingsItem(
            icon: Icons.lock_outline,
            title: "Change PIN",
            onTap: () {
              ToastService.showInfo(context, 'Feature coming soon!');
            },
          ),
          const Divider(color: AppColors.dividerLight),
          SettingsSwitch(
            icon: Icons.fingerprint,
            title: "Biometric Login",
            value: biometricsEnabled,
            onChanged: (value) async {
              final LocalAuthentication auth = LocalAuthentication();
              bool isSupported = await auth.isDeviceSupported();
              List<BiometricType> biometrics =
                  await auth.getAvailableBiometrics();
              if (isSupported && biometrics.isNotEmpty) {
                bool didAuthenticate = await auth.authenticate(
                  localizedReason:
                      'Please authenticate to enable biometric login',
                );
                if (!didAuthenticate) {
                  ToastService.showError(
                      context, 'Biometric authentication failed');
                  return;
                }
              } else {
                ToastService.showError(
                    context, 'Biometric authentication not available');
                return;
              }
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool("biometrics_enabled", value);
              biometricsEnabled = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
