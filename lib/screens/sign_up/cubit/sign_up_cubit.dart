import 'package:client/core/utils/app_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void onFullNameChanged(String fullName) {
    final fullNameError = AppUtils.validationName(fullName);
    emit(state.copyWith(fullName: fullName, fullNameError: fullNameError));
  }

  void onEmailChanged(String email) {
    final emailError = AppUtils.validationEmail(email);
    emit(state.copyWith(email: email, emailError: emailError));
  }

  void onPasswordChanged(String password) {
    final passwordError = AppUtils.validationPassword(password);
    emit(state.copyWith(password: password, passwordError: passwordError));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> signUp() async {}
}
