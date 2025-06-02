import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Data/Models/Spent%20Card%20Model/SpentCardModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'add_new_spent_state.dart';

class AddNewSpentCubit extends Cubit<AddNewSpentState> {
  AddNewSpentCubit() : super(AddNewSpentInitial());

  addNewSpentCard(SpentCardModel spentCardModel) async {
    try {
      emit(AddNewSpentLoading());
      Box<SpentCardModel> spentBox = Hive.box<SpentCardModel>(kSpentBox);
      await spentBox.add(spentCardModel);
      emit(AddNewSpentSuccess(spentCardModel));
    } on Exception catch (e) {
      emit(AddNewSpentFailure(e.toString()));
    }
  }
}
