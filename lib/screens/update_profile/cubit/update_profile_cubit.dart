import 'package:client/core/utils/app_utils.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/update_profile_request.dart';
import 'package:client/data/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enums/status_enum.dart';
import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  static const List<String> genderOptions = ['male', 'female', 'other'];

  final UserRepository userRepository;

  UpdateProfileCubit({required this.userRepository}) : super(const UpdateProfileState());

  Future<void> initialize() async {
    try {
      final response = await userRepository.getProfile();
      emit(
        state.copyWith(
          initUser: response,
          updatedUser: response,
          phoneNumber: response.phoneNumber,
          name: response.name,
          dateOfBirth: response.dateOfBirth,
          gender: _normalizeGender(response.gender),
        ),
      );
    } on ApiException catch (e) {
      debugPrint('initialize error: ${e.toString()}');
    }
  }

  void onPhoneNumberChanged(String phoneNumber) {
    final phoneNumberError = AppUtils.validationPhoneNumber(phoneNumber);
    emit(state.copyWith(phoneNumber: phoneNumber, phoneNumberError: phoneNumberError));
  }

  void onNameChanged(String name) {
    final nameError = AppUtils.validationName(name);
    emit(state.copyWith(name: name, nameError: nameError));
  }

  void onDateOfBirthChanged(String dateOfBirth) {
    emit(state.copyWith(dateOfBirth: dateOfBirth));
  }

  void onGenderChanged(String gender) {
    final normalizedGender = _normalizeGender(gender);
    emit(state.copyWith(gender: normalizedGender));
  }

  Future<void> submitUpdateProfile() async {
    onPhoneNumberChanged(state.phoneNumber);
    onNameChanged(state.name);
    onDateOfBirthChanged(state.dateOfBirth);
    onGenderChanged(state.gender);

    if (!state.isValid) {
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing, errorMessage: ''));
    try {
      final request = UpdateProfileRequest(
        phoneNumber: state.phoneNumber.trim(),
        name: state.name.trim(),
        dateOfBirth: state.dateOfBirth.trim(),
        gender: state.gender.trim().toLowerCase(),
      );

      await userRepository.updateProfile(request);
      emit(state.copyWith(status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  void resetStatus() {
    emit(state.copyWith(status: StatusEnum.initial, errorMessage: ''));
  }

  String _normalizeGender(String value) {
    final gender = value.trim().toLowerCase();
    switch (gender) {
      case 'nam':
        return 'male';
      case 'nữ':
      case 'nu':
        return 'female';
      case 'khác':
      case 'khac':
        return 'other';
      default:
        return gender;
    }
  }
}
