part of 'payment_cubit.dart';

class PaymentState {
  final BookingModel? booking;
  final StatusEnum status;
  final StatusEnum statusPayment;
  final String? paymentUrl;
  final String errorMessage;

  PaymentState({
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.booking,
    this.statusPayment = StatusEnum.initial,
    this.paymentUrl,
  });

  PaymentState copyWith({
    BookingModel? booking,
    StatusEnum? status,
    String? errorMessage,
    StatusEnum? statusPayment,
    String? paymentUrl,
  }) {
    return PaymentState(
      booking: booking ?? this.booking,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      statusPayment: statusPayment ?? this.statusPayment,
      paymentUrl: paymentUrl ?? this.paymentUrl,
    );
  }
}
