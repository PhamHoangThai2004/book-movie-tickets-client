import 'package:equatable/equatable.dart';

import '../../../data/enums/status_enum.dart';

class ForgetPasswordState extends Equatable {
  static const int otpCountdownDurationInSeconds = 300;

  final String email;
  final String otp;
  final String verifyToken;
  final String password;
  final String emailError;
  final String otpError;
  final String passwordError;
  final int otpCountdownSeconds;
  final StatusEnum status;
  final String errorMessage;
  final ForgetPasswordStep step;

  const ForgetPasswordState({
    this.email = '',
    this.otp = '',
    this.verifyToken = '',
    this.password = '',
    this.emailError = '',
    this.otpError = '',
    this.passwordError = '',
    this.otpCountdownSeconds = otpCountdownDurationInSeconds,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.step = ForgetPasswordStep.inputForm,
  });

  bool get isFormValid => email.isNotEmpty && emailError.isEmpty;

  bool get isOtpValid => RegExp(r'^\d{6}$').hasMatch(otp);

  bool get canVerifyOtp => isOtpValid && otpError.isEmpty && otpCountdownSeconds > 0;

  bool get isResetPasswordValid =>
      password.isNotEmpty && passwordError.isEmpty && verifyToken.isNotEmpty;

  bool get isOtpExpired => otpCountdownSeconds <= 0;

  ForgetPasswordState copyWith({
    String? email,
    String? otp,
    String? verifyToken,
    String? password,
    String? emailError,
    String? otpError,
    String? passwordError,
    int? otpCountdownSeconds,
    StatusEnum? status,
    String? errorMessage,
    ForgetPasswordStep? step,
  }) {
    return ForgetPasswordState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      verifyToken: verifyToken ?? this.verifyToken,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      otpError: otpError ?? this.otpError,
      passwordError: passwordError ?? this.passwordError,
      otpCountdownSeconds: otpCountdownSeconds ?? this.otpCountdownSeconds,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      step: step ?? this.step,
    );
  }

  @override
  List<Object?> get props => [
    email,
    otp,
    verifyToken,
    password,
    emailError,
    otpError,
    passwordError,
    otpCountdownSeconds,
    status,
    errorMessage,
    step,
  ];
}

enum ForgetPasswordStep { inputForm, otpVerify, resetPassword }
