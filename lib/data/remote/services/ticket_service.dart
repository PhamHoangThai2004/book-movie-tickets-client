import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../model/ticket_preview_model.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/auth_interceptor.dart';
import '../requests/ticket_request.dart';
import '../responses/pagination_response.dart';

@injectable
class TicketService {
  final String _ticketPath = 'users/tickets';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), AuthInterceptor()]);

  Future<PaginationResponse<TicketPreviewModel>> getTickets(TicketRequest request) async {
    try {
      final response = await _dio.get(_ticketPath, queryParameters: request.toJson());
      final result = PaginationResponse<TicketPreviewModel>.fromJson(
        response.data,
        (json) => TicketPreviewModel.fromJson(json as Map<String, dynamic>),
      );
      return result;
    } on ApiException {
      rethrow;
    }
  }
}
