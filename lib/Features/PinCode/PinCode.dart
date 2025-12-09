import 'package:flutter/material.dart';
import 'package:fundflow/Core/ToastService.dart';
import 'package:fundflow/Features/HomeView/Presentation/NewHomeViewBody.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

import '../../Core/AppColors.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
      // First-time user
      setState(() {
        isCreatingPin = true;
      });
    } else {
      // Returning user
      setState(() {
        isCreatingPin = false;
        isConfirmingPin = false;
      });
    }
    if (biometricsEnabled && isBiometricsAvailable) {
      Future.delayed(const Duration(milliseconds: 400), () {
        authenticateBiometric();
      });
    }
  }

  void enterNumber(String n) {
    if (pin.length >= 6) return;

    setState(() {
      pin += n;
    });

    if (pin.length == 6) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (isCreatingPin) {
          _handleNewPin();
        } else if (isConfirmingPin) {
          _handlePinConfirmation();
        } else {
          _validateExistingPin();
        }
      });
    }
  }

  void deleteNumber() {
    if (pin.isNotEmpty) {
      setState(() {
        pin = pin.substring(0, pin.length - 1);
      });
    }
  }

  Future<void> _handleNewPin() async {
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
      });

      if (isBiometricsAvailable) {
        // _showBiometricActivationDialog();
      } else {
        setState(() => isAuthenticated = true);
      }
    } else {
      setState(() {
        isError = true;
      });

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
    String savedPin = prefs.getString("user_pin")!;

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
      // ToastService.showError(context, '');
      debugPrint("Biometric error: $e");
    }
  }

  Future<void> _showBiometricActivationDialog() async {
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
    if (isAuthenticated) {
      return const NewHomeViewBody();
    }

    String title = "Enter your PIN";

    if (isCreatingPin) title = "Create a PIN";
    if (isConfirmingPin) title = "Confirm PIN";

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            /// TITLE
            Text(
              title,
              style: const TextStyle(
                color: AppColors.darkBlueColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 40),

            /// PIN DOTS
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
                    color: filled ? AppColors.primaryDark : Colors.transparent,
                    border: Border.all(
                      color: AppColors.darkBlueColor,
                      width: 2,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            /// ERROR MESSAGE
            if (isError)
              const Text(
                "Incorrect PIN. Try again.",
                style: TextStyle(
                  color: AppColors.warningOrange,
                  fontSize: 16,
                ),
              ),

            // const SizedBox(height: 50),

            /// BIOMETRIC ICON
            // if (!isCreatingPin &&
            //     !isConfirmingPin &&
            //     biometricsEnabled &&
            //     isBiometricsAvailable)
            //   GestureDetector(
            //     onTap: authenticateBiometric,
            //     child: ScaleTransition(
            //       scale: _pulseAnimation,
            //       child: const Icon(
            //         Icons.fingerprint,
            //         size: 80,
            //         color: AppColors.lightOrangeColor,
            //       ),
            //     ),
            //   ),

            const Spacer(),

            /// KEYPAD
            _buildKeypad(),
            const SizedBox(height: 30),
            if (!isCreatingPin &&
                !isConfirmingPin &&
                biometricsEnabled &&
                isBiometricsAvailable)
              GestureDetector(
                onTap: authenticateBiometric,
                child: const Icon(
                  Icons.fingerprint,
                  size: 80,
                  color: AppColors.primaryDark,
                ),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ----------------- KEYPAD -----------------------
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.map((value) {
        if (value == "del") {
          return _keypadButton(
            child: const Icon(Icons.backspace, color: AppColors.darkBlueColor),
            onTap: deleteNumber,
          );
        } else if (value == "") {
          return _keypadButton(child: const SizedBox());
        } else {
          return _keypadButton(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                color: AppColors.darkBlueColor,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.darkBlueColor,
            width: 1.5,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
