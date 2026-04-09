import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../network/interceptors/auth_interceptor.dart';

@injectable
class PaymentService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), AuthInterceptor()]);

  // Future<List<ShowtimePreviewModel>> getShowtimes(ShowtimeRequest request) async {
  //   try {
  //     final response = await _dio.get(_showtimePath, queryParameters: request.toJson());
  //     final result = ModelResponse<List<ShowtimePreviewModel>>.fromJson(
  //       response.data,
  //           (json) => (json as List)
  //           .map((e) => ShowtimePreviewModel.fromJson(e as Map<String, dynamic>))
  //           .toList(),
  //     );
  //     return result.data;
  //   } on ApiException {
  //     rethrow;
  //   }
  // }
}
