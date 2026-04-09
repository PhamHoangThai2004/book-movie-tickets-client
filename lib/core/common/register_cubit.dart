import 'package:client/screens/change_password/cubit/change_password_cubit.dart';
import 'package:client/screens/forget_password/cubit/forget_password_cubit.dart';
import 'package:client/screens/movie/cubit/movie_cubit.dart';
import 'package:client/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:client/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/book_tickets/cubit/book_tickets_cubit.dart';
import '../../screens/dashboard/cubit/dashboard_cubit.dart';
import '../../screens/movie_detail/cubit/movie_detail_cubit.dart';
import '../../screens/sign_in/cubit/sign_in_cubit.dart';

extension RegisterCubit on BuildContext {
  DashboardCubit get dashboardCubit => read<DashboardCubit>();

  SignInCubit get signInCubit => read<SignInCubit>();

  SignUpCubit get signUpCubit => read<SignUpCubit>();

  ForgetPasswordCubit get forgetPasswordCubit => read<ForgetPasswordCubit>();

  UpdateProfileCubit get updateProfileCubit => read<UpdateProfileCubit>();

  ChangePasswordCubit get changePasswordCubit => read<ChangePasswordCubit>();

  MovieCubit get movieCubit => read<MovieCubit>();

  MovieDetailCubit get movieDetailCubit => read<MovieDetailCubit>();

  BookTicketsCubit get bookTicketsCubit => read<BookTicketsCubit>();
}
