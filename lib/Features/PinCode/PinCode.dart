import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/Core/ToastService.dart';
import 'package:fundflow/Features/HomeView/Presentation/NewHomeViewBody.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

import '../../Core/AppColors.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/AppTextStyles.dart';

class PinCode extends StatefulWidget {
  const PinCode({super.key});

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> with SingleTickerProviderStateMixin {
  final LocalAuthentication auth = LocalAuthentication();

  String pin = "";
  String tempNewPin = "";
  bool isError = false;
  bool isAuthenticated = false;
  bool isBiometricsAvailable = false;

  bool isCreatingPin = false;
  bool isConfirmingPin = false;
  bool biometricsEnabled = false;

  @override
  void initState() {
    super.initState();
    _initSetup();
  }

  Future<void> _initSetup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedPin = prefs.getString("user_pin");
    biometricsEnabled = prefs.getBool("biometrics_enabled") ?? false;

    isBiometricsAvailable = await auth.canCheckBiometrics;

    if (savedPin == null) {
      setState(() {
        isCreatingPin = true;
      });
    }

    if (biometricsEnabled && isBiometricsAvailable && savedPin != null) {
      Future.delayed(const Duration(milliseconds: 400), authenticateBiometric);
    }
  }

  void enterNumber(String n) {
    if (pin.length >= 6) return;

    setState(() {
      pin += n;
    });

    if (pin.length == 6) {
      if (isCreatingPin) {
        _handleNewPin();
      } else if (isConfirmingPin) {
        _handlePinConfirmation();
      } else {
        _validateExistingPin();
      }
    }
  }

  void deleteNumber() {
    if (pin.isNotEmpty) {
      setState(() {
        pin = pin.substring(0, pin.length - 1);
      });
    }
  }

  void _handleNewPin() {
    tempNewPin = pin;
    setState(() {
      pin = "";
      isCreatingPin = false;
      isConfirmingPin = true;
    });
  }

  Future<void> _handlePinConfirmation() async {
    if (pin == tempNewPin) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_pin", pin);

      setState(() {
        pin = "";
        tempNewPin = "";
        isConfirmingPin = false;
        isAuthenticated = true;
      });
    } else {
      setState(() => isError = true);

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          pin = "";
          isError = false;
        });
      });
    }
  }

  Future<void> _validateExistingPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPin = prefs.getString("user_pin");

    if (savedPin == null) return; // safeguard

    if (pin == savedPin) {
      setState(() => isAuthenticated = true);
    } else {
      setState(() => isError = true);

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          pin = "";
          isError = false;
        });
      });
    }
  }

  Future<void> authenticateBiometric() async {
    if (!biometricsEnabled) {
      ToastService.showInfo(context, 'Biometrics not enabled');
      return;
    }

    try {
      bool result = await auth.authenticate(
        localizedReason: "Authenticate to unlock",
      );

      if (result) {
        setState(() => isAuthenticated = true);
      }
    } catch (e) {
      log("Biometric error: $e");
    }
  }

  Future<void> showBiometricActivationDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          "Enable Biometrics?",
          style: TextStyle(color: AppColors.darkText),
        ),
        content: const Text(
          "Would you like to use fingerprint or face ID to unlock the app?",
          style: TextStyle(color: AppColors.darkText),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool("biometrics_enabled", false);
              Navigator.pop(context);
              setState(() => isAuthenticated = true);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool("biometrics_enabled", true);
              Navigator.pop(context);
              authenticateBiometric();
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthenticated) return const NewHomeViewBody();
    final colors = Theme.of(context).colorScheme;
    String title = "enterPin".tr();
    if (isCreatingPin) title = "createPin".tr();
    if (isConfirmingPin) title = "confirmPin".tr();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Text(
              title,
              style: AppTextStyles.headerSectionTitle(context).copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                bool filled = index < pin.length;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? colors.primary : Colors.transparent,
                    border: Border.all(
                      color: colors.onSurface,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            if (isError)
              Text(
                "incorrectPin".tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            const Spacer(),
            _buildKeypad(),
            const SizedBox(height: 30),
            if (!isCreatingPin &&
                !isConfirmingPin &&
                biometricsEnabled &&
                isBiometricsAvailable)
              GestureDetector(
                onTap: authenticateBiometric,
                child: Icon(
                  Icons.fingerprint,
                  size: 80,
                  color: colors.primary,
                ),
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        _buildKeypadRow(["1", "2", "3"]),
        const SizedBox(height: 10),
        _buildKeypadRow(["4", "5", "6"]),
        const SizedBox(height: 10),
        _buildKeypadRow(["7", "8", "9"]),
        const SizedBox(height: 10),
        _buildKeypadRow(["", "0", "del"]),
      ],
    );
  }

  Widget _buildKeypadRow(List<String> items) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.map((value) {
        if (value == "del") {
          return _keypadButton(
            child: Icon(Icons.backspace_outlined, color: colors.primary),
            onTap: deleteNumber,
          );
        } else if (value == "") {
          return _keypadButton(child: const SizedBox());
        } else {
          return _keypadButton(
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onTap: () => enterNumber(value),
          );
        }
      }).toList(),
    );
  }

  Widget _keypadButton({required Widget child, VoidCallback? onTap}) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colors.primary,
            width: 1.5,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
