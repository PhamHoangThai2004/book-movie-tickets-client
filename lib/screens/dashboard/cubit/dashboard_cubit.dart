import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_utils.dart';
import '../../../data/model/user_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final UserRepository userRepository;

  DashboardCubit(this.userRepository) : super(const DashboardState());

  Future<void> getUserInfo() async {
    if (!AppUtils.isLoggedIn()) return;
    try {
      final userInfo = await userRepository.getProfile();
      emit(state.copyWith(userInfo: userInfo));
    } on ApiException catch (e) {
      debugPrint('getUserInfo error: ${e.toString()}');
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
