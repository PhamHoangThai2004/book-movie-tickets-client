import 'package:client/data/remote/services/ticket_service.dart';
import 'package:injectable/injectable.dart';

import '../model/ticket_model.dart';
import '../model/ticket_preview_model.dart';
import '../network/exceptions/api_exception.dart';
import '../remote/requests/ticket_request.dart';
import '../remote/responses/pagination_response.dart';

abstract class TicketRepository {
  Future<PaginationResponse<TicketPreviewModel>> getTickets(TicketRequest request);

  Future<TicketModel> getTicketById(String id);
}

@Injectable(as: TicketRepository)
class TicketRepositoryImpl implements TicketRepository {
  final TicketService _ticketService;

  TicketRepositoryImpl({required TicketService ticketService}) : _ticketService = ticketService;

  @override
  Future<PaginationResponse<TicketPreviewModel>> getTickets(TicketRequest request) async {
    try {
      final response = await _ticketService.getTickets(request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<TicketModel> getTicketById(String id) async {
    try {
      final response = await _ticketService.getTicketById(id);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }
}
