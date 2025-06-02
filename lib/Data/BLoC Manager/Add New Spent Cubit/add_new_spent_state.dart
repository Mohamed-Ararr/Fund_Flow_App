part of 'add_new_spent_cubit.dart';

@immutable
abstract class AddNewSpentState {}

class AddNewSpentInitial extends AddNewSpentState {}

class AddNewSpentLoading extends AddNewSpentState {}

class AddNewSpentSuccess extends AddNewSpentState {
  final SpentCardModel spentCardModel;

  AddNewSpentSuccess(this.spentCardModel);
}

class AddNewSpentFailure extends AddNewSpentState {
  final String errorMsg;

  AddNewSpentFailure(this.errorMsg);
}
