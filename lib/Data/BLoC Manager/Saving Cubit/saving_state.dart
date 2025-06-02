part of 'saving_cubit.dart';

@immutable
abstract class SavingState {}

class SavingInitial extends SavingState {}

class SavingLoading extends SavingState {}

class SavingSuccess extends SavingState {
  final List<SavingCardModel> savingCardsList;

  SavingSuccess(this.savingCardsList);
}

class SavingFailure extends SavingState {
  final String errorMsg;

  SavingFailure(this.errorMsg);
}
