import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../ContValues.dart';
import '../../Models/BalanceEntryModel/BalanceEntryModel.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  fetchUserBalance() async {
    double currentBalance;
    try {
      emit(UserLoading());
      currentBalance = Hive.box<double>(kbalanceBox).get(kbalanceBox) ?? 0.0;
      emit(UserSuccess(currentBalance));
    } on Exception catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  // Method to retrieve current balance AND historical data
  fetchUserBalanceNew() async {
    try {
      emit(UserLoading());

      // 1. Fetch current balance
      final balanceBox = Hive.box<double>(kbalanceBox);
      final currentBalance = balanceBox.get(kbalanceBox) ?? 0.0;

      // 2. Fetch historical entries
      final historyBox = Hive.box<BalanceEntryModel>(kbalanceHistoryBox);
      // Retrieve and sort the history by date (essential for charts)
      final history = historyBox.values.toList()
        ..sort((a, b) => a.date.compareTo(b.date));

      // 3. Emit success with both pieces of data
      emit(UserSuccessNew(currentBalance: currentBalance, history: history));
    } on Exception catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  // New method to log a balance entry and update the balance
  Future<void> logBalanceEntry({
    required double amount,
    required String date,
    required String title,
  }) async {
    // 1. Ensure state is ready (optional but safer)
    if (state is! UserSuccess) {
      await fetchUserBalance();
      if (state is! UserSuccess) return;
    }

    final successState = state as UserSuccessNew;

    try {
      final historyBox = Hive.box<BalanceEntryModel>(kbalanceHistoryBox);
      final balanceBox = Hive.box<double>(kbalanceBox);

      // --- Log the Entry ---
      final newEntry =
          BalanceEntryModel(amount: amount, date: date, title: title);
      await historyBox.add(newEntry);

      // --- Update the Total Balance ---
      // 'amount' here should already be signed (negative for expense, positive for income/credit)
      final newBalance = successState.currentBalance + amount;
      await balanceBox.put(kbalanceBox, newBalance);

      // --- Emit Updated State ---
      // Create a new list for immutability
      final updatedHistory =
          List<BalanceEntryModel>.from(successState.history as Iterable)
            ..add(newEntry)
            ..sort((a, b) => a.date.compareTo(b.date));

      emit(UserSuccessNew(currentBalance: newBalance, history: updatedHistory));
    } on Exception catch (e) {
      // If logging fails, re-fetch data or show error
      log('Error logging entry: $e');
      emit(UserFailure('Failed to log entry: ${e.toString()}'));
    }
  }
}
