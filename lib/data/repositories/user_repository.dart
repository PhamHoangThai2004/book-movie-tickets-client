import 'package:injectable/injectable.dart';

import '../model/user_model.dart';
import '../network/exceptions/api_exception.dart';
import '../remote/requests/change_password_request.dart';
import '../remote/requests/update_profile_request.dart';
import '../remote/services/user_service.dart';

abstract class UserRepository {
  Future<UserModel> getProfile();

  Future<void> updateProfile(UpdateProfileRequest request);

  Future<void> changePassword(ChangePasswordRequest request);
}

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl({required UserService userService}) : _userService = userService;

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await _userService.getProfile();
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<void> updateProfile(UpdateProfileRequest request) async {
    try {
      await _userService.updateProfile(request);
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    try {
      await _userService.changePassword(request);
    } catch (e) {
      throw ApiException.error(e);
    }
  }
}
