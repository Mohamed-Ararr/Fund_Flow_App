import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Data/Models/Debt%20Card%20Model/DebtCardModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'debt_state.dart';

class DebtCubit extends Cubit<DebtState> {
  DebtCubit() : super(DebtInitial());

  fetchDebtCards() {
    try {
      emit(DebtLoading());
      Box<DebtCardModel> debtBox = Hive.box<DebtCardModel>(kDebtBox);
      List<DebtCardModel> debtsList = debtBox.values.toList();
      emit(DebtSuccess(debtsList));
    } catch (e) {
      emit(DebtFailure(e.toString()));
    }
  }
}
