import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/verify_otp_request.dart';
import 'package:injectable/injectable.dart';

import '../model/login_model.dart';
import '../remote/requests/login_request.dart';
import '../remote/requests/register_request.dart';
import '../remote/requests/reset_password_request.dart';
import '../remote/services/auth_service.dart';

abstract class AuthRepository {
  Future<LoginModel> login(LoginRequest request);

  Future<void> register(RegisterRequest request);

  Future<String?> verifyOtp(VerifyOtpRequest request);

  Future<void> resendOtp(String email, String type);

  Future<void> resetPasswordRequest(String email);

  Future<void> resetPassword(ResetPasswordRequest request);
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

  @override
  Future<void> register(RegisterRequest request) async {
    try {
      await _authService.register(request);
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<String?> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response = await _authService.verifyOtp(request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<void> resendOtp(String email, String type) async {
    try {
      await _authService.resendOtp(email, type);
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    try {
      await _authService.resetPassword(request);
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<void> resetPasswordRequest(String email) async {
    try {
      await _authService.resetPasswordRequest(email);
    } catch (e) {
      throw ApiException.error(e);
    }
  }
}
