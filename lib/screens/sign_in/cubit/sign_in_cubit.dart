import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/login_request.dart';
import 'package:client/data/repositories/auth_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_utils.dart';
import '../../../data/enums/status_enum.dart';
import '../../../data/local/preferences.dart';
import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;

  SignInCubit({required this.authRepository}) : super(const SignInState());

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

  Future<void> signIn() async {
    final email = state.email;
    final password = state.password;
    onEmailChanged(email);
    onPasswordChanged(password);
    if (!state.isValid) {
      return;
    }
    emit(state.copyWith(status: StatusEnum.processing));

    try {
      final request = LoginRequest(email: email.trim(), password: password.trim());
      final response = await authRepository.login(request);
      await Preferences.instance.saveAccessToken(response.accessToken);
      await Preferences.instance.saveRefreshToken(response.refreshToken);
      emit(state.copyWith(status: StatusEnum.success));
    } on ApiException catch (e) {
      debugPrint('signIn error: ${e.errorMessage}');
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
