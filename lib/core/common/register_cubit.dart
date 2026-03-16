import 'package:client/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/dashboard/cubit/dashboard_cubit.dart';
import '../../screens/sign_in/cubit/sign_in_cubit.dart';

extension RegisterCubit on BuildContext {
  DashboardCubit get dashboardCubit => read<DashboardCubit>();

  SignInCubit get signInCubit => read<SignInCubit>();

  SignUpCubit get signUpCubit => read<SignUpCubit>();
}
