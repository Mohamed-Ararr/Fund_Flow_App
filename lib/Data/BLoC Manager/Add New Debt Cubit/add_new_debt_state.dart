part of 'add_new_debt_cubit.dart';

@immutable
abstract class AddNewDebtState {}

class AddNewDebtInitial extends AddNewDebtState {}

class AddNewDebtLoading extends AddNewDebtState {}

class AddNewDebtSuccess extends AddNewDebtState {
  final DebtCardModel debtCardModel;

  AddNewDebtSuccess(this.debtCardModel);
}

class AddNewDebtFailure extends AddNewDebtState {
  final String errorMsg;

  AddNewDebtFailure(this.errorMsg);
}
