part of 'ticket_cubit.dart';

class TicketState extends Equatable {
  final PaginationResponse<TicketPreviewModel>? tickets;
  final StatusEnum status;
  final String errorMessage;
  final bool isLoadingMore;

  const TicketState({
    this.tickets,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.isLoadingMore = false,
  });

  List<TicketPreviewModel> get ticketsList => tickets?.items ?? [];

  TicketState copyWith({
    PaginationResponse<TicketPreviewModel>? tickets,
    StatusEnum? status,
    String? errorMessage,
    bool? isLoadingMore,
  }) {
    return TicketState(
      tickets: tickets ?? this.tickets,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [tickets, status, errorMessage, isLoadingMore];
}
