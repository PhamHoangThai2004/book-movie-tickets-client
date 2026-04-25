import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/repositories/payment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'payment_detail_state.dart';

@injectable
class PaymentDetailCubit extends Cubit<PaymentDetailState> {
  final PaymentRepository _paymentRepository;

  PaymentDetailCubit(this._paymentRepository) : super(PaymentDetailState());

  Future<void> cancelPayment(String paymentId) async {
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      await _paymentRepository.cancelPayment(paymentId);
      emit(state.copyWith(status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
