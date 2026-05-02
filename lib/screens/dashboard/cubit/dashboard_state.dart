part of 'dashboard_cubit.dart';

class DashboardState {
  final UserModel? userInfo;
  final bool haveUnreadNotifications;
  final bool deviceTokenAdded;
  final StatusEnum status;

  const DashboardState({
    this.userInfo,
    this.haveUnreadNotifications = false,
    this.deviceTokenAdded = false,
    this.status = StatusEnum.initial,
  });

  DashboardState copyWith({
    UserModel? userInfo,
    bool? haveUnreadNotifications,
    bool? deviceTokenAdded,
    StatusEnum? status,
  }) {
    return DashboardState(
      userInfo: userInfo ?? this.userInfo,
      haveUnreadNotifications: haveUnreadNotifications ?? this.haveUnreadNotifications,
      deviceTokenAdded: deviceTokenAdded ?? this.deviceTokenAdded,
      status: status ?? this.status,
    );
  }
}
