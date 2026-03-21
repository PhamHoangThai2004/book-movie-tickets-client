import 'dart:async';

import 'package:client/core/utils/app_utils.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/verify_otp_request.dart';
import 'package:client/data/repositories/auth_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enums/status_enum.dart';
import '../../../data/remote/requests/reset_password_request.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository authRepository;
  Timer? _otpTimer;

  ForgetPasswordCubit({required this.authRepository}) : super(const ForgetPasswordState());

  void onEmailChanged(String email) {
    final emailError = AppUtils.validationEmail(email);
    emit(state.copyWith(email: email, emailError: emailError));
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

  void onPasswordChanged(String password) {
    final passwordError = AppUtils.validationPassword(password);
    emit(state.copyWith(password: password, passwordError: passwordError));
  }

  void backToInputForm() {
    _stopOtpCountdown();
    emit(
      state.copyWith(
        step: ForgetPasswordStep.inputForm,
        status: StatusEnum.initial,
        otp: '',
        verifyToken: '',
        password: '',
        otpError: '',
        passwordError: '',
        email: '',
        emailError: '',
        otpCountdownSeconds: ForgetPasswordState.otpCountdownDurationInSeconds,
      ),
    );
  }

  void backToOtpVerify() {
    emit(state.copyWith(step: ForgetPasswordStep.otpVerify, status: StatusEnum.initial));
  }

  void startOtpCountdown() {
    _stopOtpCountdown();
    emit(
      state.copyWith(
        otp: '',
        otpError: '',
        otpCountdownSeconds: ForgetPasswordState.otpCountdownDurationInSeconds,
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

  Future<void> requestResetPassword() async {
    final email = state.email;
    onEmailChanged(email);
    if (!state.isFormValid) {
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing));
    try {
      await authRepository.resetPasswordRequest(email.trim());
      emit(state.copyWith(status: StatusEnum.initial, step: ForgetPasswordStep.otpVerify));
      startOtpCountdown();
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> verifyOtp() async {
    if (!state.canVerifyOtp) {
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final request = VerifyOtpRequest(email: state.email.trim(), type: 'reset', otpCode: state.otp);
      final verifyToken = await authRepository.verifyOtp(request);
      emit(
        state.copyWith(
          status: StatusEnum.initial,
          step: ForgetPasswordStep.resetPassword,
          verifyToken: verifyToken ?? '',
          password: '',
          passwordError: '',
        ),
      );
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> submitResetPassword() async {
    onPasswordChanged(state.password);
    if (!state.isResetPasswordValid) {
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final request = ResetPasswordRequest(
        email: state.email.trim(),
        password: state.password.trim(),
        verifyToken: state.verifyToken,
      );
      await authRepository.resetPassword(request);
      emit(state.copyWith(status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> resendOtp() async {
    if (!state.isOtpExpired) {
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing));
    try {
      await authRepository.resendOtp(state.email.trim(), 'reset');
      emit(state.copyWith(status: StatusEnum.initial));
      startOtpCountdown();
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  void _stopOtpCountdown() {
    _otpTimer?.cancel();
    _otpTimer = null;
  }

  @override
  Future<void> close() {
    _stopOtpCountdown();
    return super.close();
  }
}


