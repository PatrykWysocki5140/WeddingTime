import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:wedding_time/services/authenticate.dart';

part 'reset_pass_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  resetPassword(String email) async {
    await FireStoreUtils.resetPassword(email);
    emit(ResetPasswordDone());
  }

  checkValidField(GlobalKey<FormState> key) {
    if (key.currentState?.validate() ?? false) {
      key.currentState!.save();
      emit(ValidResetPasswordField());
    } else {
      emit(ResetPasswordFailureState(errorMessage: 'Invalid email address.'));
    }
  }
}
