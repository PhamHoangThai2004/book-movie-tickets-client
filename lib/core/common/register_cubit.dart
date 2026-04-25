import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/book_tickets/cubit/book_tickets_cubit.dart';
import '../../screens/change_password/cubit/change_password_cubit.dart';
import '../../screens/dashboard/cubit/dashboard_cubit.dart';
import '../../screens/forget_password/cubit/forget_password_cubit.dart';
import '../../screens/home/cubit/home_cubit.dart';
import '../../screens/movie/cubit/movie_cubit.dart';
import '../../screens/movie_detail/cubit/movie_detail_cubit.dart';
import '../../screens/payment/cubit/payment_cubit.dart';
import '../../screens/payment_detail/cubit/payment_detail_cubit.dart';
import '../../screens/payment_history/cubit/payment_history_cubit.dart';
import '../../screens/sign_in/cubit/sign_in_cubit.dart';
import '../../screens/sign_up/cubit/sign_up_cubit.dart';
import '../../screens/ticket/cubit/ticket_cubit.dart';
import '../../screens/update_profile/cubit/update_profile_cubit.dart';

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

  PaymentCubit get paymentCubit => read<PaymentCubit>();

  PaymentHistoryCubit get paymentHistoryCubit => read<PaymentHistoryCubit>();

  TicketCubit get ticketCubit => read<TicketCubit>();

  HomeCubit get homeCubit => read<HomeCubit>();

  PaymentDetailCubit get paymentDetailCubit => read<PaymentDetailCubit>();
}
