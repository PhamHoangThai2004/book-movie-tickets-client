part of 'dashboard_cubit.dart';

class DashboardState {
  final UserModel? userInfo;
  final bool haveUnreadNotifications;

  const DashboardState({this.userInfo, this.haveUnreadNotifications = false});

  DashboardState copyWith({UserModel? userInfo, bool? haveUnreadNotifications}) {
    return DashboardState(
      userInfo: userInfo ?? this.userInfo,
      haveUnreadNotifications: haveUnreadNotifications ?? this.haveUnreadNotifications,
    );
  }
}
