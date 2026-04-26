part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final StatusEnum loadStatus;
  final String errorMessage;
  final PaginationResponse<NotificationModel>? notifications;
  final StatusEnum status;

  const NotificationState({
    this.loadStatus = StatusEnum.initial,
    this.errorMessage = '',
    this.notifications,
    this.status = StatusEnum.initial,
  });

  int get currentPage => notifications?.page ?? 1;

  bool get hasMore => notifications?.hasMore ?? false;

  List<NotificationModel> get items => notifications?.items ?? [];

  NotificationState copyWith({
    StatusEnum? loadStatus,
    String? errorMessage,
    PaginationResponse<NotificationModel>? notifications,
    StatusEnum? status,
  }) {
    return NotificationState(
      loadStatus: loadStatus ?? this.loadStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      notifications: notifications ?? this.notifications,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [loadStatus, errorMessage, notifications, status];
}
