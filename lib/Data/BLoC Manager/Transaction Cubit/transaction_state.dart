part of 'transaction_cubit.dart';

// The base state for the Transaction Cubit
abstract class TransactionState {}

// Initial state, before any action is taken
class TransactionInitial extends TransactionState {}

// State when data is being loaded from Hive
class TransactionLoading extends TransactionState {}

// State when transactions are successfully loaded
class TransactionLoaded extends TransactionState {
  final List<TransactionModel> transactions;

  TransactionLoaded(this.transactions);
}

// State when an error occurs
class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}
