import 'package:client/data/model/user_model.dart';
import 'package:client/data/remote/requests/update_profile_request.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/auth_interceptor.dart';
import '../responses/model_response.dart';

@injectable
class UserService {
  final String _profilePath = 'account/users/profile';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), AuthInterceptor()]);

  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get(_profilePath);
      final result = ModelResponse<UserModel>.fromJson(
        response.data,
        (json) => UserModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    try {
      await _dio.patch(_profilePath, data: request.toJson());
    } on ApiException {
      rethrow;
    }
  }
}
