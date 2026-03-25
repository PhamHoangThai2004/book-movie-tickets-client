import 'package:equatable/equatable.dart';

import '../../../data/enums/status_enum.dart';

class ChangePasswordState extends Equatable {
  final String oldPassword;
  final String newPassword;

  final bool isOldPasswordVisible;
  final bool isNewPasswordVisible;

  final String oldPasswordError;
  final String newPasswordError;

  final StatusEnum status;
  final String errorMessage;

  const ChangePasswordState({
	this.oldPassword = '',
	this.newPassword = '',
	this.isOldPasswordVisible = false,
	this.isNewPasswordVisible = false,
	this.oldPasswordError = '',
	this.newPasswordError = '',
	this.status = StatusEnum.initial,
	this.errorMessage = '',
  });

  bool get isValid =>
	  oldPassword.isNotEmpty &&
	  newPassword.isNotEmpty &&
	  oldPasswordError.isEmpty &&
	  newPasswordError.isEmpty;

  bool get canSubmit => isValid && status != StatusEnum.processing;

  ChangePasswordState copyWith({
	String? oldPassword,
	String? newPassword,
	bool? isOldPasswordVisible,
	bool? isNewPasswordVisible,
	String? oldPasswordError,
	String? newPasswordError,
	StatusEnum? status,
	String? errorMessage,
  }) {
	return ChangePasswordState(
	  oldPassword: oldPassword ?? this.oldPassword,
	  newPassword: newPassword ?? this.newPassword,
	  isOldPasswordVisible: isOldPasswordVisible ?? this.isOldPasswordVisible,
	  isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
	  oldPasswordError: oldPasswordError ?? this.oldPasswordError,
	  newPasswordError: newPasswordError ?? this.newPasswordError,
	  status: status ?? this.status,
	  errorMessage: errorMessage ?? this.errorMessage,
	);
  }

  @override
  List<Object?> get props => [
	oldPassword,
	newPassword,
	isOldPasswordVisible,
	isNewPasswordVisible,
	oldPasswordError,
	newPasswordError,
	status,
	errorMessage,
  ];
}

