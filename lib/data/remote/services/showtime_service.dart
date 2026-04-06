import 'package:client/data/model/showtime_preview_model.dart';
import 'package:client/data/remote/requests/showtime_request.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../model/showtime_model.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/auth_interceptor.dart';
import '../responses/model_response.dart';

@injectable
class ShowtimeService {
  final String _showtimePath = 'users/showtimes';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), AuthInterceptor()]);

  Future<List<ShowtimePreviewModel>> getShowtimes(ShowtimeRequest request) async {
    try {
      final response = await _dio.get(_showtimePath, queryParameters: request.toJson());
      final result = ModelResponse<List<ShowtimePreviewModel>>.fromJson(
        response.data,
        (json) => (json as List)
            .map((e) => ShowtimePreviewModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<ShowtimeModel> getShowtimeById(String id) async {
    try {
      final response = await _dio.get('$_showtimePath/$id');
      final result = ModelResponse.fromJson(
        response.data,
        (json) => ShowtimeModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }
}
