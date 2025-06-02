import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../ContValues.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  fetchUserBalance() async {
    double currentBalance;
    try {
      emit(UserLoading());
      currentBalance = Hive.box<double>(kbalanceBox).get(kbalanceBox) ?? 0.0;
      emit(UserSuccess(currentBalance));
    } on Exception catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
