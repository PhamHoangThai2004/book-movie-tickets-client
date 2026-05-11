import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/repositories/ticket_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enums/status_enum.dart';
import '../../../data/model/ticket_model.dart';
import '../../../data/model/ticket_preview_model.dart';
import '../../../data/remote/requests/ticket_request.dart';
import '../../../data/remote/responses/pagination_response.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final TicketRepository ticketRepository;

  TicketCubit({required this.ticketRepository}) : super(const TicketState());

  Future<void> fetchTickets() async {
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final request = TicketRequest(page: 1, size: 10);
      final response = await ticketRepository.getTickets(request);

      emit(state.copyWith(tickets: response, status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> loadMoreTickets() async {
    if (state.status == StatusEnum.processing || state.isLoadingMore) return;

    final currentData = state.tickets;
    if (currentData == null) return;

    if (!currentData.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final request = TicketRequest(page: currentData.page + 1, size: 10);
      final response = await ticketRepository.getTickets(request);

      final mergedData = currentData.copyWith(
        items: [...currentData.items, ...response.items],
        page: response.page,
        hasMore: response.hasMore,
      );

      emit(state.copyWith(tickets: mergedData, status: StatusEnum.success, isLoadingMore: false));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: StatusEnum.failure,
          errorMessage: e.errorMessage,
          isLoadingMore: false,
        ),
      );
    }
  }

  Future<void> fetchTicketById(String id) async {
    emit(state.copyWith(statusDetail: StatusEnum.processing));
    try {
      final response = await ticketRepository.getTicketById(id);
      emit(state.copyWith(ticket: response, statusDetail: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(statusDetail: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
