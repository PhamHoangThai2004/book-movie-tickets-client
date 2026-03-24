import 'package:injectable/injectable.dart';

import '../model/user_model.dart';
import '../network/exceptions/api_exception.dart';
import '../remote/requests/update_profile_request.dart';
import '../remote/services/user_service.dart';

abstract class UserRepository {
  Future<UserModel> getProfile();

  Future<void> updateProfile(UpdateProfileRequest request);
}

@Injectable(as: UserRepository)
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
}
