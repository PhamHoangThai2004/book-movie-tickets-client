import 'package:client/data/remote/services/payment_service.dart';
import 'package:injectable/injectable.dart';

import '../model/booking_model.dart';
import '../network/exceptions/api_exception.dart';

abstract class PaymentRepository {
  Future<BookingModel> getBookingById(String id);

  Future<String> createPayment(String bookingId);
}

@Injectable(as: PaymentRepository)
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
}
