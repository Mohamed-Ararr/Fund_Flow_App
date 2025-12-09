import 'dart:developer';

import 'package:flutter/material.dart';
import '../../InsightsFeature/InsightsView.dart';
import 'NewComponents/DashboardHeader.dart';
import 'NewComponents/DebtsList.dart';
import 'NewComponents/TransactionsList.dart';
import 'Widgets/CustomBottomAppBar.dart';

class NewHomeViewBody extends StatefulWidget {
  const NewHomeViewBody({super.key});

  @override
  State<NewHomeViewBody> createState() => _NewHomeViewBodyState();
}

class _NewHomeViewBodyState extends State<NewHomeViewBody> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // Home
            log("Navigate to Home");
          } else if (index == 1) {
            // Insights
            log("Navigate to Insights");
          }
        },
      ),
      body: SafeArea(
        child: _currentIndex == 0
            ? const SingleChildScrollView(
                child: Column(
                  children: [
                    DashboardHeader(),
                    TransactionsList(),
                    DebtsList(),
                  ],
                ),
              )
            : const Center(
                child: InsightsView(),
              ),
      ),
    );
  }
}
