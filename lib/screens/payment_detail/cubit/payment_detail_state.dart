part of 'payment_detail_cubit.dart';

class PaymentDetailState {
  final StatusEnum status;
  final String errorMessage;

  PaymentDetailState({this.status = StatusEnum.initial, this.errorMessage = ''});

  PaymentDetailState copyWith({StatusEnum? status, String? errorMessage}) {
    return PaymentDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
