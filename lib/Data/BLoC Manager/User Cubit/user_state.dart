part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final double currentBalance;

  UserSuccess(this.currentBalance);
}

class UserSuccessNew extends UserState {
  final double currentBalance;
  final List<BalanceEntryModel>? history;

  UserSuccessNew({required this.currentBalance, this.history});
}

class UserFailure extends UserState {
  final String errorMsg;

  UserFailure(this.errorMsg);
}
