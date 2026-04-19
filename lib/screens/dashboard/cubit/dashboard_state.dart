part of 'dashboard_cubit.dart';

class DashboardState {
  final UserModel? userInfo;

  const DashboardState({this.userInfo});

  DashboardState copyWith({UserModel? userInfo}) {
    return DashboardState(userInfo: userInfo ?? this.userInfo);
  }
}
