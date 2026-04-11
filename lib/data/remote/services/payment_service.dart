import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../model/booking_model.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/auth_interceptor.dart';
import '../responses/model_response.dart';

@injectable
class PaymentService {
  final String _bookingPath = 'users/bookings';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), AuthInterceptor()]);

  Future<BookingModel> getBookingById(String id) async {
    try {
      final path = '$_bookingPath/$id';
      final response = await _dio.get(path);
      final result = ModelResponse<BookingModel>.fromJson(
        response.data,
        (json) => BookingModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }
}
