import 'dart:async';

import 'package:client/core/utils/app_utils.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/verify_otp_request.dart';
import 'package:client/data/repositories/auth_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enums/status_enum.dart';
import '../../../data/remote/requests/register_request.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  Timer? _otpTimer;

  SignUpCubit({required this.authRepository}) : super(const SignUpState());

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

  void backToInputForm() {
    _stopOtpCountdown();
    emit(
      state.copyWith(
        signInStep: SignInStep.inputForm,
        otp: '',
        otpError: '',
        email: '',
        emailError: '',
        password: '',
        passwordError: '',
        fullName: '',
        fullNameError: '',
        otpCountdownSeconds: SignUpState.otpCountdownDurationInSeconds,
      ),
    );
  }

  void onOtpChanged(String otp) {
    final formattedOtp = otp.trim();
    final isNumberOnly = RegExp(r'^\d*$').hasMatch(formattedOtp);

    emit(
      state.copyWith(
        otp: formattedOtp,
        otpError: formattedOtp.isEmpty || isNumberOnly ? '' : 'otp_error'.tr(),
      ),
    );
  }

  void startOtpCountdown() {
    _stopOtpCountdown();
    emit(
      state.copyWith(
        otp: '',
        otpError: '',
        otpCountdownSeconds: SignUpState.otpCountdownDurationInSeconds,
      ),
    );

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final nextSeconds = state.otpCountdownSeconds - 1;
      if (nextSeconds <= 0) {
        timer.cancel();
        emit(state.copyWith(otpCountdownSeconds: 0));
        return;
      }

      emit(state.copyWith(otpCountdownSeconds: nextSeconds));
    });
  }

  void _stopOtpCountdown() {
    _otpTimer?.cancel();
    _otpTimer = null;
  }

  Future<void> signUp() async {
    final fullName = state.fullName;
    final email = state.email;
    final password = state.password;

    onFullNameChanged(fullName);
    onEmailChanged(email);
    onPasswordChanged(password);

    if (!state.isValid) {
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final request = RegisterRequest(name: fullName, email: email, password: password);
      await authRepository.register(request);
      emit(state.copyWith(status: StatusEnum.initial, signInStep: SignInStep.otpVerify));
      startOtpCountdown();
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> verifyOtp() async {
    if (!state.canVerifyOtp) {
      return;
    }

    final otp = state.otp;
    final email = state.email;
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final request = VerifyOtpRequest(email: email, type: 'register', otpCode: otp);
      await authRepository.verifyOtp(request);
      emit(state.copyWith(status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> resendOtp() async {
    if (!state.isOtpExpired) {
      return;
    }

    final email = state.email;
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      await authRepository.resendOtp(email, 'register');
      emit(state.copyWith(status: StatusEnum.initial));
      startOtpCountdown();
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  @override
  Future<void> close() {
    _stopOtpCountdown();
    return super.close();
  }
}
