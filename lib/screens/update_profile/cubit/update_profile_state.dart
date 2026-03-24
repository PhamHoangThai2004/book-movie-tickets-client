import 'package:client/data/model/user_model.dart';

import '../../../data/enums/status_enum.dart';

class UpdateProfileState {
  final String phoneNumber;
  final String name;
  final String dateOfBirth;
  final String gender;

  final String phoneNumberError;
  final String nameError;
  final String dateOfBirthError;
  final String genderError;

  final StatusEnum status;
  final String errorMessage;
  final UserModel? initUser;
  final UserModel? updatedUser;

  const UpdateProfileState({
    this.phoneNumber = '',
    this.name = '',
    this.dateOfBirth = '',
    this.gender = 'male',
    this.phoneNumberError = '',
    this.nameError = '',
    this.dateOfBirthError = '',
    this.genderError = '',
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.initUser,
    this.updatedUser,
  });

  bool get isValid =>
      phoneNumber.isNotEmpty &&
      name.isNotEmpty &&
      dateOfBirth.isNotEmpty &&
      gender.isNotEmpty &&
      phoneNumberError.isEmpty &&
      nameError.isEmpty &&
      dateOfBirthError.isEmpty &&
      genderError.isEmpty;

  UpdateProfileState copyWith({
    String? phoneNumber,
    String? name,
    String? dateOfBirth,
    String? gender,
    String? phoneNumberError,
    String? nameError,
    String? dateOfBirthError,
    String? genderError,
    StatusEnum? status,
    String? errorMessage,
    UserModel? initUser,
    UserModel? updatedUser,
  }) {
    return UpdateProfileState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
      nameError: nameError ?? this.nameError,
      dateOfBirthError: dateOfBirthError ?? this.dateOfBirthError,
      genderError: genderError ?? this.genderError,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      initUser: initUser ?? this.initUser,
      updatedUser: updatedUser ?? this.updatedUser,
    );
  }
}
