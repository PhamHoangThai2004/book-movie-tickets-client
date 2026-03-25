import 'package:client/core/utils/app_utils.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/change_password_request.dart';
import 'package:client/data/repositories/user_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enums/status_enum.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final UserRepository userRepository;

  ChangePasswordCubit({required this.userRepository}) : super(const ChangePasswordState());

  void onOldPasswordChanged(String oldPassword) {
    final oldPasswordError = oldPassword.trim().isEmpty ? 'current_password_empty_error'.tr() : '';
    emit(state.copyWith(oldPassword: oldPassword, oldPasswordError: oldPasswordError));
  }

  void onNewPasswordChanged(String newPassword) {
    final newPasswordError = AppUtils.validationNewPassword(newPassword);
    emit(state.copyWith(newPassword: newPassword, newPasswordError: newPasswordError));
  }

  void toggleOldPasswordVisibility() {
    emit(state.copyWith(isOldPasswordVisible: !state.isOldPasswordVisible));
  }

  void toggleNewPasswordVisibility() {
    emit(state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible));
  }

  Future<void> submitChangePassword() async {
    onOldPasswordChanged(state.oldPassword);
    onNewPasswordChanged(state.newPassword);

    if (!state.isValid) {
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing, errorMessage: ''));
    try {
      final request = ChangePasswordRequest(
        oldPassword: state.oldPassword.trim(),
        newPassword: state.newPassword.trim(),
      );

      await userRepository.changePassword(request);
      emit(state.copyWith(status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
