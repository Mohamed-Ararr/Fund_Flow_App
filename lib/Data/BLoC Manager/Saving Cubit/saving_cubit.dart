import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Data/Models/Saving%20Card%20Model/SavingCardModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'saving_state.dart';

class SavingCubit extends Cubit<SavingState> {
  SavingCubit() : super(SavingInitial());

  fetchSavingCards() {
    try {
      emit(SavingLoading());
      Box<SavingCardModel> savingBox = Hive.box<SavingCardModel>(kSavingBox);
      List<SavingCardModel> savingList = savingBox.values.toList();
      emit(SavingSuccess(savingList));
    } catch (e) {
      emit(SavingFailure(e.toString()));
    }
  }
}
