import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundflow/ContValues.dart';
import 'package:fundflow/Data/Models/Spent%20Card%20Model/SpentCardModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../Models/Spent Detail Model/SpentDetailModel.dart';

part 'spent_state.dart';

class SpentCubit extends Cubit<SpentState> {
  SpentCubit() : super(SpentInitial());

  List<SpentDetailModel>? spentL = [];

  fetchSpentCards() {
    try {
      emit(SpentLoading());
      Box<SpentCardModel> spentBox = Hive.box<SpentCardModel>(kSpentBox);
      List<SpentCardModel>? spentList = spentBox.values.toList();
      // Extract and flatten all non-null spentsList entries
      spentL = spentList
          .where((card) => card.spentsList != null)
          .expand((card) => card.spentsList!)
          .toList();
      emit(SpentSuccess(spentList));
    } on Exception catch (e) {
      emit(SpentFailure(e.toString()));
    }
  }
}

// fetchSpentCards() {
//     List<double>? cardsBalance;
//     emit(SpentLoading());
//     Box<List<double>> cardsBox = Hive.box<List<double>>(kSpentCardsListBox);
//     cardsBalance = cardsBox.get(kSpentCardsListBox) ??
//         [
//           0.0,
//           0.0,
//           0.0,
//           0.0,
//         ];
//     emit(SpentSuccess(cardsBalance));
//   }
