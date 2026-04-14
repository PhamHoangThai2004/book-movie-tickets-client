import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../model/booking_model.dart';
import '../../model/payment_model.dart';
import '../../model/payment_preview_model.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/auth_interceptor.dart';
import '../requests/payment_request.dart';
import '../responses/model_response.dart';
import '../responses/pagination_response.dart';

@injectable
class PaymentService {
  final String _bookingPath = 'users/bookings';
  final String _paymentPath = 'users/payments';

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

  Future<String> createPayment(String bookingId) async {
    try {
      final response = await _dio.post(_paymentPath, data: {'bookingId': bookingId});
      String paymentUrl = response.data['data']['paymentUrl'];

      if (paymentUrl.startsWith("VNP_URL=")) {
        paymentUrl = paymentUrl.substring("VNP_URL=".length);
      }

      return paymentUrl;
    } on ApiException {
      rethrow;
    }
  }

  Future<PaginationResponse<PaymentPreviewModel>> getPayments(PaymentRequest request) async {
    try {
      final response = await _dio.get(_paymentPath, queryParameters: request.toJson());
      final result = PaginationResponse<PaymentPreviewModel>.fromJson(
        response.data,
        (json) => PaymentPreviewModel.fromJson(json as Map<String, dynamic>),
      );
      return result;
    } on ApiException {
      rethrow;
    }
  }

  Future<PaymentModel> getPaymentById(String id) async {
    try {
      final path = '$_paymentPath/$id';
      final response = await _dio.get(path);
      final result = ModelResponse<PaymentModel>.fromJson(
        response.data,
        (json) => PaymentModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }
}
