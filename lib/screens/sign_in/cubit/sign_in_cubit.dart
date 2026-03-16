import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_utils.dart';
import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void onEmailChanged(String email) {
    final emailError = AppUtils.validationEmail(email);
    emit(state.copyWith(email: email, emailError: emailError));
  }

  void onPasswordChanged(String password) {
    final passwordError = password.trim().isEmpty ? 'password_empty_error'.tr() : '';
    emit(state.copyWith(password: password, passwordError: passwordError));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> signIn() async {}
}
