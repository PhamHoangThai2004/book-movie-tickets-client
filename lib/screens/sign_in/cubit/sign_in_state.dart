import 'package:equatable/equatable.dart';

import '../../../data/enums/status_enum.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordVisible;
  final String emailError;
  final String passwordError;
  final StatusEnum status;
  final String? errorMessage;

  const SignInState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.emailError = '',
    this.passwordError = '',
    this.status = StatusEnum.initial,
    this.errorMessage,
  });

  bool get isValid => 
      email.isNotEmpty && 
      password.isNotEmpty && 
      emailError.isEmpty && 
      passwordError.isEmpty;

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    String? emailError,
    String? passwordError,
    StatusEnum? status,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isPasswordVisible,
    emailError,
    passwordError,
    status,
    errorMessage,
  ];
}
