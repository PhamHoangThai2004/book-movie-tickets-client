import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/repositories/payment_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/booking_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentCubit({required this.paymentRepository}) : super(PaymentState());

  Future<void> getBookingDetail(String id) async {
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final response = await paymentRepository.getBookingById(id);
      emit(state.copyWith(status: StatusEnum.success, booking: response));
    } on ApiException catch (e) {
      debugPrint(e.toString());
    }
  }
}
