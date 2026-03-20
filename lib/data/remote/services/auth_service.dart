import 'package:client/data/model/login_model.dart';
import 'package:client/data/remote/requests/login_request.dart';
import 'package:client/data/remote/responses/model_response.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/general_interceptor.dart';

@injectable
class AuthService {
  final signInPath = 'account/auth/login';

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
}
