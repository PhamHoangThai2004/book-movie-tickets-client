import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/payment_model.dart';
import '../../../data/model/payment_preview_model.dart';
import '../../../data/remote/requests/payment_request.dart';
import '../../../data/remote/responses/pagination_response.dart';

part 'payment_history_state.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  final PaymentRepository paymentRepository;

  PaymentHistoryCubit({required this.paymentRepository}) : super(const PaymentHistoryState());

  Future<void> fetchBookingHistory() async {
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final request = PaymentRequest();
      final result = await paymentRepository.getPayments(request);

      emit(state.copyWith(status: StatusEnum.success, payments: result));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> loadMoreBookings() async {
    if (!state.hasMore || state.status == StatusEnum.processing) return;

    try {
      final nextPage = state.currentPage + 1;
      final request = PaymentRequest(page: nextPage, size: state.pageSize);
      final result = await paymentRepository.getPayments(request);

      emit(state.copyWith(payments: result));
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.errorMessage));
    }
  }

  Future<void> refreshBookingHistory() async {
    emit(state.copyWith(status: StatusEnum.processing));
    await fetchBookingHistory();
  }

  Future<void> getPaymentDetail(String id) async {
    emit(state.copyWith(statusLoad: StatusEnum.processing));
    try {
      final response = await paymentRepository.getPaymentById(id);
      emit(state.copyWith(statusLoad: StatusEnum.success, payment: response));
    } on ApiException catch (e) {
      emit(state.copyWith(statusLoad: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
