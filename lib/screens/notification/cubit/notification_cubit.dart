import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/model/notification_model.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/notification_request.dart';
import 'package:client/data/remote/responses/pagination_response.dart';
import 'package:client/data/repositories/notification_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _notificationRepository;

  NotificationCubit(this._notificationRepository) : super(const NotificationState());

  Future<void> fetchNotifications() async {
    emit(state.copyWith(loadStatus: StatusEnum.processing));
    try {
      final request = NotificationRequest();
      final result = await _notificationRepository.getNotifications(request);

      emit(state.copyWith(loadStatus: StatusEnum.success, notifications: result));
    } on ApiException catch (e) {
      emit(state.copyWith(loadStatus: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> loadMoreNotifications() async {
    if (!state.hasMore) {
      return;
    }
    try {
      final nextPage = state.currentPage + 1;
      final request = NotificationRequest(page: nextPage);
      final result = await _notificationRepository.getNotifications(request);

      final oldItems = state.notifications?.items ?? [];
      final newItems = result.items;
      final mergedItems = [...oldItems, ...newItems];

      final mergedResponse = result.copyWith(items: mergedItems, page: nextPage);

      emit(state.copyWith(notifications: mergedResponse));
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.errorMessage));
    }
  }

  Future<void> markAllSeen() async {
    try {
      emit(state.copyWith(status: StatusEnum.processing));
      await _notificationRepository.markAllSeen();
      final response = await _notificationRepository.getNotifications(NotificationRequest());
      emit(state.copyWith(notifications: response, status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.errorMessage, status: StatusEnum.failure));
    }
  }
}

