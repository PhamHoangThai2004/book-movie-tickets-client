part of 'payment_history_cubit.dart';

class PaymentHistoryState extends Equatable {
  final StatusEnum status;
  final String errorMessage;
  final StatusEnum statusLoad;
  final PaginationResponse<PaymentPreviewModel>? payments;
  final PaymentModel? payment;
  final bool isLoadMore;

  const PaymentHistoryState({
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.statusLoad = StatusEnum.initial,
    this.payments,
    this.payment,
    this.isLoadMore = false,
  });

  bool get hasMore => payments?.hasMore ?? false;

  int get currentPage => payments?.page ?? 1;

  int get pageSize => payments?.pageSize ?? 10;

  PaymentHistoryState copyWith({
    StatusEnum? status,
    String? errorMessage,
    StatusEnum? statusLoad,
    PaginationResponse<PaymentPreviewModel>? payments,
    PaymentModel? payment,
    bool? isLoadMore,
  }) {
    return PaymentHistoryState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      payments: payments ?? this.payments,
      statusLoad: statusLoad ?? this.statusLoad,
      payment: payment ?? this.payment,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, payments, statusLoad, payment, isLoadMore];
}
