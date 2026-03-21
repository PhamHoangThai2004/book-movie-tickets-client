import 'package:client/data/model/login_model.dart';
import 'package:client/data/remote/requests/login_request.dart';
import 'package:client/data/remote/requests/register_request.dart';
import 'package:client/data/remote/requests/verify_otp_request.dart';
import 'package:client/data/remote/responses/model_response.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/general_interceptor.dart';
import '../requests/reset_password_request.dart';

@injectable
class AuthService {
  final signInPath = 'account/auth/login';
  final signUpPath = 'account/auth/register';
  final verifyOtpPath = 'account/auth/verify-otp';
  final resendOtpPath = 'account/auth/resend-otp';
  final resetPasswordRequestPath = 'account/auth/reset-password-request';
  final resetPasswordPath = 'account/auth/reset-password';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), GeneralInterceptor()]);

  Future<LoginModel> login(LoginRequest request) async {
    try {
      final response = await _dio.post(signInPath, data: request.toJson());
      final result = ModelResponse<LoginModel>.fromJson(
        response.data,
        (json) => LoginModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> register(RegisterRequest request) async {
    try {
      await _dio.post(signUpPath, data: request.toJson());
    } on ApiException {
      rethrow;
    }
  }

  Future<String?> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response = await _dio.post(verifyOtpPath, data: request.toJson());
      return response.data['data']['verifytToken'];
    } on ApiException {
      rethrow;
    }
  }

  Future<void> resendOtp(String email, String type) async {
    try {
      await _dio.post(resendOtpPath, data: {'email': email, 'type': type});
    } on ApiException {
      rethrow;
    }
  }

  Future<void> resetPasswordRequest(String email) async {
    try {
      await _dio.post(resetPasswordRequestPath, data: {'email': email});
    } on ApiException {
      rethrow;
    }
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    try {
      await _dio.post(resetPasswordPath, data: request.toJson());
    } on ApiException {
      rethrow;
    }
  }
}
