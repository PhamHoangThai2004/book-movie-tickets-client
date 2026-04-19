import 'package:client/data/model/payment_preview_model.dart';
import 'package:client/data/remote/services/payment_service.dart';
import 'package:injectable/injectable.dart';

import '../model/booking_model.dart';
import '../model/payment_model.dart';
import '../network/exceptions/api_exception.dart';
import '../remote/requests/payment_request.dart';
import '../remote/responses/pagination_response.dart';

abstract class PaymentRepository {
  Future<BookingModel> getBookingById(String id);

  Future<String> createPayment(String bookingId);

  Future<PaginationResponse<PaymentPreviewModel>> getPayments(PaymentRequest request);

  Future<PaymentModel> getPaymentById(String id);
}

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentService _paymentService;

  PaymentRepositoryImpl({required PaymentService paymentService})
    : _paymentService = paymentService;

  @override
  Future<BookingModel> getBookingById(String id) async {
    try {
      final response = await _paymentService.getBookingById(id);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<String> createPayment(String bookingId) async {
    try {
      final response = await _paymentService.createPayment(bookingId);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<PaginationResponse<PaymentPreviewModel>> getPayments(PaymentRequest request) async {
    try {
      final response = await _paymentService.getPayments(request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<PaymentModel> getPaymentById(String id) async {
    try {
      final response = await _paymentService.getPaymentById(id);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }
}
