part of 'ticket_cubit.dart';

class TicketState extends Equatable {
  final PaginationResponse<TicketPreviewModel>? tickets;
  final StatusEnum status;
  final String errorMessage;
  final bool isLoadingMore;
  final TicketModel? ticket;
  final StatusEnum statusDetail;

  const TicketState({
    this.tickets,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.isLoadingMore = false,
    this.ticket,
    this.statusDetail = StatusEnum.initial,
  });

  List<TicketPreviewModel> get ticketsList => tickets?.items ?? [];

  TicketState copyWith({
    TicketModel? ticket,
    PaginationResponse<TicketPreviewModel>? tickets,
    StatusEnum? status,
    String? errorMessage,
    StatusEnum? statusDetail,
    bool? isLoadingMore,
  }) {
    return TicketState(
      tickets: tickets ?? this.tickets,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      ticket: ticket ?? this.ticket,
      statusDetail: statusDetail ?? this.statusDetail,
    );
  }

  @override
  List<Object?> get props => [tickets, status, errorMessage, isLoadingMore, ticket, statusDetail];
}
