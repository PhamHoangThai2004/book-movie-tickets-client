import 'package:client/data/remote/responses/pagination_response.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../model/notification_model.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/auth_interceptor.dart';
import '../requests/notification_request.dart';

@lazySingleton
class NotificationService {
  final String _notificationPath = 'notifications';
  final String _markSeenPath = 'notifications/{id}/seen';
  final String _markAllSeenPath = 'notifications/seen/all';
  final String _unreadCountPath = 'notifications/unread-count';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), AuthInterceptor()]);

  Future<PaginationResponse<NotificationModel>> getNotifications(
    NotificationRequest request,
  ) async {
    try {
      final response = await _dio.get(_notificationPath, queryParameters: request.toJson());
      final result = PaginationResponse<NotificationModel>.fromJson(
        response.data,
        (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
      );
      return result;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> markNotification(String id) async {
    try {
      final path = _markSeenPath.replaceAll('{id}', id);
      await _dio.patch(path);
    } on ApiException {
      rethrow;
    }
  }

  Future<void> markAllSeen() async {
    try {
      await _dio.patch(_markAllSeenPath);
    } on ApiException {
      rethrow;
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _dio.get(_unreadCountPath);
      return response.data['data']['count'];
    } on ApiException {
      rethrow;
    }
  }
}
