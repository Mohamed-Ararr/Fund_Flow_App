import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Data/Models/Debt%20Card%20Model/DebtCardModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'add_new_debt_state.dart';

class AddNewDebtCubit extends Cubit<AddNewDebtState> {
  AddNewDebtCubit() : super(AddNewDebtInitial());

  addNewDebtCard(DebtCardModel debtCardModel) async {
    try {
      emit(AddNewDebtLoading());
      Box<DebtCardModel> debtBox = Hive.box<DebtCardModel>(kDebtBox);
      debtBox.add(debtCardModel);
      emit(AddNewDebtSuccess(debtCardModel));
    } catch (e) {
      emit(AddNewDebtFailure(e.toString()));
    }
  }
}
