part of 'add_new_saving_cubit.dart';

@immutable
abstract class AddNewSavingState {}

class AddNewSavingInitial extends AddNewSavingState {}

class AddNewSavingLoading extends AddNewSavingState {}

class AddNewSavingSuccess extends AddNewSavingState {
  final SavingCardModel savingCardModel;

  AddNewSavingSuccess(this.savingCardModel);
}

class AddNewSavingFailure extends AddNewSavingState {
  final String errorMsg;

  AddNewSavingFailure(this.errorMsg);
}
