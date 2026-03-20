import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:injectable/injectable.dart';

import '../model/login_model.dart';
import '../remote/requests/login_request.dart';
import '../remote/services/auth_service.dart';

abstract class AuthRepository {
  Future<LoginModel> login(LoginRequest request);
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService}) : _authService = authService;

  @override
  Future<LoginModel> login(LoginRequest request) async {
    try {
      return await _authService.login(request);
    } catch (e) {
      throw ApiException.error(e);
    }
  }
}
