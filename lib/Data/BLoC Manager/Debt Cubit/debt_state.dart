part of 'debt_cubit.dart';

@immutable
abstract class DebtState {}

class DebtInitial extends DebtState {}

class DebtLoading extends DebtState {}

class DebtSuccess extends DebtState {
  final List<DebtCardModel> debtsList;

  DebtSuccess(this.debtsList);
}

class DebtFailure extends DebtState {
  final String errorMsg;

  DebtFailure(this.errorMsg);
}
