part of 'payment_history_cubit.dart';

class PaymentHistoryState extends Equatable {
  final StatusEnum status;
  final String errorMessage;
  final PaginationResponse<PaymentPreviewModel>? payments;

  const PaymentHistoryState({
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.payments,
  });

  bool get hasMore => payments?.hasMore ?? false;
  int get currentPage => payments?.page ?? 1;
  int get pageSize => payments?.pageSize ?? 10;

  PaymentHistoryState copyWith({
    StatusEnum? status,
    String? errorMessage,
    PaginationResponse<PaymentPreviewModel>? payments,
  }) {
    return PaymentHistoryState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      payments: payments ?? this.payments,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, payments];
}
