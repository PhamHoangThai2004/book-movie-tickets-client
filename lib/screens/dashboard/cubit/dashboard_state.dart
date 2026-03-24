import '../../../data/model/user_model.dart';

class DashboardState {
  final UserModel? userInfo;

  const DashboardState({this.userInfo});

  DashboardState copyWith({UserModel? userInfo}) {
    return DashboardState(userInfo: userInfo ?? this.userInfo);
  }
}
