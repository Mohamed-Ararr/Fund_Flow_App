import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/Data/Models/Saving%20Card%20Model/SavingCardModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../ContValues.dart';

part 'add_new_saving_state.dart';

class AddNewSavingCubit extends Cubit<AddNewSavingState> {
  AddNewSavingCubit() : super(AddNewSavingInitial());

  addNewSavingCard(SavingCardModel savingCardModel) async {
    try {
      emit(AddNewSavingLoading());
      Box<SavingCardModel> savingBox = Hive.box<SavingCardModel>(kSavingBox);
      await savingBox.add(savingCardModel);
      emit(AddNewSavingSuccess(savingCardModel));
    } on Exception catch (e) {
      emit(AddNewSavingFailure(e.toString()));
    }
  }
}
