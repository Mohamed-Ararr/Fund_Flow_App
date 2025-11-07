import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fundflow/Core/helper.dart";
import "package:fundflow/Data/BLoC%20Manager/User%20Cubit/user_cubit.dart";

import "../../../../../ContValues.dart";
import "../../../../../Core/AppColors.dart";
import "../../../../../Core/AppFonts.dart";

import "../../../../../Core/cache_service.dart";

import 'dart:ui';

class TotalBalanceWidget extends StatefulWidget {
  const TotalBalanceWidget({super.key});

  @override
  State<TotalBalanceWidget> createState() => _TotalBalanceWidgetState();
}

class _TotalBalanceWidgetState extends State<TotalBalanceWidget> {
  bool _hideBalance = false;

  @override
  void initState() {
    super.initState();
    _loadBalanceVisibility();
  }

  Future<void> _loadBalanceVisibility() async {
    final hidden = await CacheService.getHideBalance();
    if (mounted) {
      setState(() => _hideBalance = hidden);
    }
  }

  Future<void> _toggleVisibility() async {
    setState(() => _hideBalance = !_hideBalance);
    await CacheService.setHideBalance(_hideBalance);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Balance",
                style: AppTextStyles.bodyLarge(context).copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: _toggleVisibility,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Actual balance text
                    Text(
                      "${Helper.formatCurrency(state.currentBalance)} ${getCurrency()}",
                      style: AppTextStyles.headline1(context).copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    // Blur overlay
                    if (_hideBalance)
                      Positioned.fill(
                        child: ClipRect(
                          child: BackdropFilter(
                            blendMode: BlendMode.srcIn,
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: Container(
                              color: Colors.white.withValues(alpha: 0),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is UserFailure) {
          return Text(state.errorMsg);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
