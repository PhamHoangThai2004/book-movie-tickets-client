import 'package:equatable/equatable.dart';

import '../../../data/enums/status_enum.dart';

class SignUpState extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final bool isPasswordVisible;
  final String fullNameError;
  final String emailError;
  final String passwordError;
  final StatusEnum status;
  final String? errorMessage;

  const SignUpState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.fullNameError = '',
    this.emailError = '',
    this.passwordError = '',
    this.status = StatusEnum.initial,
    this.errorMessage,
  });

  bool get isValid => 
      fullName.isNotEmpty && 
      email.isNotEmpty && 
      password.isNotEmpty && 
      fullNameError.isEmpty && 
      emailError.isEmpty && 
      passwordError.isEmpty;

  SignUpState copyWith({
    String? fullName,
    String? email,
    String? password,
    bool? isPasswordVisible,
    String? fullNameError,
    String? emailError,
    String? passwordError,
    StatusEnum? status,
    String? errorMessage,
  }) {
    return SignUpState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      fullNameError: fullNameError ?? this.fullNameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    email,
    password,
    isPasswordVisible,
    fullNameError,
    emailError,
    passwordError,
    status,
    errorMessage,
  ];
}
