part of 'spent_cubit.dart';

@immutable
abstract class SpentState {}

class SpentInitial extends SpentState {}

class SpentLoading extends SpentState {}

class SpentSuccess extends SpentState {
  final List<SpentCardModel> spentList;

  SpentSuccess(this.spentList);
}

class SpentFailure extends SpentState {
  final String errorMsg;

  SpentFailure(this.errorMsg);
}
