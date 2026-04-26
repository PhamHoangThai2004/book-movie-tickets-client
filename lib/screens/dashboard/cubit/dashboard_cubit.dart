import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/app_utils.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repositories/notification_repository.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final UserRepository _userRepository;
  final NotificationRepository _notificationRepository;

  DashboardCubit(this._userRepository, this._notificationRepository) : super(const DashboardState());

  Future<void> getUserInfo() async {
    if (!AppUtils.isLoggedIn()) return;
    try {
      final userInfo = await _userRepository.getProfile();
      emit(state.copyWith(userInfo: userInfo));
    } on ApiException catch (e) {
      debugPrint('getUserInfo error: ${e.toString()}');
    }
  }

  Future<void> checkHaveUnreadNotifications() async {
    try {
      final response =  await _notificationRepository.getUnreadCount();
      final result = response > 0;
      emit(state.copyWith(haveUnreadNotifications: result));
    } on ApiException catch (e) {
      debugPrint('checkHaveUnreadNotifications error: ${e.toString()}');
    }
  }

  void logout() {
    try {
      emit(state.copyWith(userInfo: null));
    } catch (e) {
      debugPrint('logout error: ${e.toString()}');
    }
  }
}
