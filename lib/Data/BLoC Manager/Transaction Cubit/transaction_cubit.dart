import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../ContValues.dart';
import '../../Models/TransactionModel/TransactionModel.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  // Pass the initial state to the super constructor
  TransactionCubit() : super(TransactionInitial());

  // Hive Box instance, initialized when Cubit is created
  late Box<TransactionModel> _transactionBox;

  // --- Initialization ---
  Future<void> init() async {
    try {
      // 1. Open the Hive Box
      if (!Hive.isBoxOpen(kTransaction)) {
        _transactionBox = await Hive.openBox<TransactionModel>(kTransaction);
      } else {
        _transactionBox = Hive.box<TransactionModel>(kTransaction);
      }

      // 2. Load the initial data
      fetchTransactions();
    } catch (e) {
      log('Error initializing TransactionCubit: $e');
      emit(TransactionError('Failed to initialize transaction database.'));
    }
  }

  // --- Data Fetching ---
  void fetchTransactions() {
    emit(TransactionLoading());
    try {
      final transactions = _transactionBox.values.toList().reversed.toList();
      log('Fetched ${transactions.length} transactions.');
      // Sort by date or another criteria if needed
      emit(TransactionLoaded(transactions.cast<TransactionModel>()));
    } catch (e) {
      log('Error fetching transactions: $e');
      emit(TransactionError('Failed to load transactions.'));
    }
  }

  // --- Data Creation ---
  Future<void> addTransaction({
    required String title,
    required String desc,
    required double spentAmount,
    required String date,
  }) async {
    try {
      final newTransaction = TransactionModel(
        title,
        desc,
        spentAmount,
        date,
      );

      // Save the new model to Hive
      await _transactionBox.add(newTransaction);
      log('Transaction added: $title | Amount: $spentAmount');

      // Refresh the state to include the new transaction
      fetchTransactions();
    } catch (e) {
      log('Error adding transaction: $e');
      emit(TransactionError('Failed to add transaction.'));
    }
  }

  // --- Data Deletion ---
  Future<void> deleteTransaction(TransactionModel transaction) async {
    try {
      // HiveObject exposes the delete method
      await transaction.delete();
      log('Transaction deleted: ${transaction.title}');

      // Refresh the state
      fetchTransactions();
    } catch (e) {
      log('Error deleting transaction: $e');
      emit(TransactionError('Failed to delete transaction.'));
    }
  }
}
