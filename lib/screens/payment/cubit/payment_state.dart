part of 'payment_cubit.dart';

class PaymentState {
  final BookingModel? booking;
  final StatusEnum status;
  final String errorMessage;

  PaymentState({this.status = StatusEnum.initial, this.errorMessage = '', this.booking});

  PaymentState copyWith({BookingModel? booking, StatusEnum? status, String? errorMessage}) {
    return PaymentState(
      booking: booking ?? this.booking,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
