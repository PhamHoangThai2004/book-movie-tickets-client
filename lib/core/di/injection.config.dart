// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:client/data/remote/services/auth_service.dart' as _i787;
import 'package:client/data/remote/services/movie_service.dart' as _i468;
import 'package:client/data/remote/services/notification_service.dart' as _i721;
import 'package:client/data/remote/services/payment_service.dart' as _i280;
import 'package:client/data/remote/services/review_service.dart' as _i548;
import 'package:client/data/remote/services/showtime_service.dart' as _i573;
import 'package:client/data/remote/services/ticket_service.dart' as _i1017;
import 'package:client/data/remote/services/user_service.dart' as _i906;
import 'package:client/data/repositories/auth_repository.dart' as _i11;
import 'package:client/data/repositories/movie_repository.dart' as _i756;
import 'package:client/data/repositories/notification_repository.dart' as _i176;
import 'package:client/data/repositories/payment_repository.dart' as _i724;
import 'package:client/data/repositories/review_repository.dart' as _i591;
import 'package:client/data/repositories/showtime_repository.dart' as _i904;
import 'package:client/data/repositories/ticket_repository.dart' as _i652;
import 'package:client/data/repositories/user_repository.dart' as _i181;
import 'package:client/screens/dashboard/cubit/dashboard_cubit.dart' as _i315;
import 'package:client/screens/home/cubit/home_cubit.dart' as _i709;
import 'package:client/screens/notification/cubit/notification_cubit.dart'
    as _i223;
import 'package:client/screens/payment_detail/cubit/payment_detail_cubit.dart'
    as _i931;
import 'package:client/screens/search/cubit/search_cubit.dart' as _i446;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i468.MovieService>(() => _i468.MovieService());
    gh.singleton<_i906.UserService>(() => _i906.UserService());
    gh.lazySingleton<_i787.AuthService>(() => _i787.AuthService());
    gh.lazySingleton<_i721.NotificationService>(
      () => _i721.NotificationService(),
    );
    gh.lazySingleton<_i280.PaymentService>(() => _i280.PaymentService());
    gh.lazySingleton<_i548.ReviewService>(() => _i548.ReviewService());
    gh.lazySingleton<_i573.ShowtimeService>(() => _i573.ShowtimeService());
    gh.lazySingleton<_i1017.TicketService>(() => _i1017.TicketService());
    gh.lazySingleton<_i176.NotificationRepository>(
      () => _i176.NotificationRepositoryImpl(
        notificationService: gh<_i721.NotificationService>(),
      ),
    );
    gh.lazySingleton<_i724.PaymentRepository>(
      () => _i724.PaymentRepositoryImpl(
        paymentService: gh<_i280.PaymentService>(),
      ),
    );
    gh.factory<_i931.PaymentDetailCubit>(
      () => _i931.PaymentDetailCubit(gh<_i724.PaymentRepository>()),
    );
    gh.lazySingleton<_i904.ShowtimeRepository>(
      () => _i904.ShowtimeRepositoryImpl(
        showtimeService: gh<_i573.ShowtimeService>(),
      ),
    );
    gh.singleton<_i181.UserRepository>(
      () => _i181.UserRepositoryImpl(userService: gh<_i906.UserService>()),
    );
    gh.singleton<_i756.MovieRepository>(
      () => _i756.MovieRepositoryImpl(movieService: gh<_i468.MovieService>()),
    );
    gh.factory<_i709.HomeCubit>(
      () => _i709.HomeCubit(gh<_i756.MovieRepository>()),
    );
    gh.factory<_i446.SearchCubit>(
      () => _i446.SearchCubit(gh<_i756.MovieRepository>()),
    );
    gh.lazySingleton<_i652.TicketRepository>(
      () =>
          _i652.TicketRepositoryImpl(ticketService: gh<_i1017.TicketService>()),
    );
    gh.lazySingleton<_i591.ReviewRepository>(
      () =>
          _i591.ReviewRepositoryImpl(reviewService: gh<_i548.ReviewService>()),
    );
    gh.factory<_i223.NotificationCubit>(
      () => _i223.NotificationCubit(gh<_i176.NotificationRepository>()),
    );
    gh.lazySingleton<_i11.AuthRepository>(
      () => _i11.AuthRepositoryImpl(authService: gh<_i787.AuthService>()),
    );
    gh.factory<_i315.DashboardCubit>(
      () => _i315.DashboardCubit(
        gh<_i181.UserRepository>(),
        gh<_i176.NotificationRepository>(),
      ),
    );
    return this;
  }
}
