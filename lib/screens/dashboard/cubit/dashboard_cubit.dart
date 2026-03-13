import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState(currentIndex: 0));

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
