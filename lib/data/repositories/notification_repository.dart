import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/responses/pagination_response.dart';
import 'package:client/data/remote/services/notification_service.dart';
import 'package:injectable/injectable.dart';

import '../model/notification_model.dart';
import '../remote/requests/notification_request.dart';

abstract class NotificationRepository {
  Future<PaginationResponse<NotificationModel>> getNotifications(NotificationRequest request);

  Future<void> markNotification(String id);

  Future<void> markAllSeen();

  Future<int> getUnreadCount();
}

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _notificationService;

  NotificationRepositoryImpl({required NotificationService notificationService})
    : _notificationService = notificationService;

  @override
  Future<PaginationResponse<NotificationModel>> getNotifications(
    NotificationRequest request,
  ) async {
    try {
      final response = await _notificationService.getNotifications(request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<void> markNotification(String id) async {
    try {
      await _notificationService.markNotification(id);
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<void> markAllSeen() async {
    try {
      await _notificationService.markAllSeen();
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      final response = await _notificationService.getUnreadCount();
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }
}
