import 'package:flutter/material.dart';
// import 'package:fundflow/Features/HomeView/Presentation/NewComponents/SavingsList.dart';
import 'NewComponents/DashboardHeader.dart';
import 'NewComponents/DebtsList.dart';
import 'NewComponents/TransactionsList.dart';

class NewHomeViewBody extends StatelessWidget {
  const NewHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DashboardHeader(),
              TransactionsList(),
              // SavingsList(),
              DebtsList(),
            ],
          ),
        ),
      ),
    );
  }
}
