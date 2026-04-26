import 'package:bot_toast/bot_toast.dart';
import 'package:client/screens/auth/auth_screen.dart';
import 'package:client/screens/auth/cubit/auth_cubit.dart';
import 'package:client/screens/change_password/change_password_screen.dart';
import 'package:client/screens/change_password/cubit/change_password_cubit.dart';
import 'package:client/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:client/screens/forget_password/cubit/forget_password_cubit.dart';
import 'package:client/screens/forget_password/forget_password_screen.dart';
import 'package:client/screens/home/cubit/home_cubit.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/movie/movie_screen.dart';
import 'package:client/screens/payment/payment_screen.dart';
import 'package:client/screens/payment_detail/payment_detail_screen.dart';
import 'package:client/screens/payment_history/cubit/payment_history_cubit.dart';
import 'package:client/screens/payment_history/payment_history_screen.dart';
import 'package:client/screens/profile/profile_screen.dart';
import 'package:client/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:client/screens/sign_in/sign_in_screen.dart';
import 'package:client/screens/sign_up/sign_up_screen.dart';
import 'package:client/screens/startup/startup_screen.dart';
import 'package:client/screens/ticket/cubit/ticket_cubit.dart';
import 'package:client/screens/ticket/ticket_screen.dart';
import 'package:client/screens/ticket_detail/ticket_detail_screen.dart';
import 'package:client/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:client/screens/update_profile/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/model/movie_model.dart';
import '../../data/model/payment_model.dart';
import '../../data/model/ticket_model.dart';
import '../../screens/book_tickets/book_tickets_screen.dart';
import '../../screens/book_tickets/cubit/book_tickets_cubit.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/movie/cubit/movie_cubit.dart';
import '../../screens/movie_detail/cubit/movie_detail_cubit.dart';
import '../../screens/movie_detail/movie_detail_screen.dart';
import '../../screens/notification/cubit/notification_cubit.dart';
import '../../screens/notification/notification_screen.dart';
import '../../screens/payment/cubit/payment_cubit.dart';
import '../../screens/payment_detail/cubit/payment_detail_cubit.dart';
import '../../screens/sign_up/cubit/sign_up_cubit.dart';
import '../di/injection.dart';

class NavigationService {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootKey');

  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorKey');

  static var params = {};
  static var extra = {};

  static String get startup => '/startup';

  static String get home => '/home';

  static String get ticket => '/ticket';

  static String get movie => '/movie';

  static String get profile => '/profile';

  static String get auth => '/auth';

  static String get signUp => '/sign-up';

  static String get signIn => '/sign-in';

  static String get forgetPassword => '/forget-password';

  static String get updateProfile => '/update-profile';

  static String get changePassword => '/change-password';

  static String get movieDetail => '/movie-detail';

  static String get bookTickets => '/book-tickets';

  static String get payment => '/payment';

  static String get paymentHistory => '/payment-history';

  static String get paymentDetail => '/payment-detail';

  static String get ticketDetail => '/ticket-detail';

  static String get notification => '/notification';

  static GoRoute commonGoRoute({
    required String path,
    required Widget page,
    required List<RouteBase> routes,
  }) => GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    name: path,
    path: path,
    pageBuilder: (context, state) {
      params.clear();
      params.addAll(state.uri.queryParameters);
      return CustomTransitionPage(
        key: state.pageKey,
        child: page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      );
    },
    builder: (BuildContext context, GoRouterState state) {
      params.clear();
      params.addAll(state.uri.queryParameters);
      return page;
    },
    routes: routes,
  );

  static GoRouter router = GoRouter(
    initialLocation: startup,
    navigatorKey: rootNavigatorKey,
    observers: [BotToastNavigatorObserver()],
    routes: [
      /// startupScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: startup,
        path: startup,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const StartupScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
        builder: (context, state) {
          return StartupScreen();
        },
      ),

      /// authScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: auth,
        path: auth,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => AuthCubit(movieRepository: getIt()),
            child: const AuthScreen(),
          ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      /// signUpScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: signUp,
        path: signUp,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => SignUpCubit(authRepository: getIt()),
            child: const SignUpScreen(),
          ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      /// signInScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: signIn,
        path: signIn,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => SignInCubit(authRepository: getIt()),
            child: const SignInScreen(),
          ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      /// forgetPasswordScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: forgetPassword,
        path: forgetPassword,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => ForgetPasswordCubit(authRepository: getIt()),
            child: const ForgetPasswordScreen(),
          ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      /// updateProfileScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: updateProfile,
        path: updateProfile,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => UpdateProfileCubit(userRepository: getIt()),
            child: const UpdateProfileScreen(),
          ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      /// changePasswordScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: changePassword,
        path: changePassword,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => ChangePasswordCubit(userRepository: getIt()),
            child: const ChangePasswordScreen(),
          ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      /// movieDetailScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: movieDetail,
        path: movieDetail,
        pageBuilder: (context, state) {
          final movie = state.extra as MovieModel;

          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => MovieDetailCubit(movieRepository: getIt()),
              child: MovieDetailScreen(movie: movie),
            ),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      /// bookTicketsScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: bookTickets,
        path: bookTickets,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final movie = extra['movie'] as MovieModel;
          final cinemaId = extra['cinemaId'] as String;

          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) =>
                  BookTicketsCubit(showtimeRepository: getIt(), movie: movie, cinemaId: cinemaId),
              child: BookTicketsScreen(),
            ),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      /// paymentScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: payment,
        path: payment,
        pageBuilder: (context, state) {
          final bookingId = state.extra as String;

          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => PaymentCubit(paymentRepository: getIt()),
              child: PaymentScreen(bookingId: bookingId),
            ),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      /// paymentHistoryScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: paymentHistory,
        path: paymentHistory,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => PaymentHistoryCubit(paymentRepository: getIt()),
              child: const PaymentHistoryScreen(),
            ),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      /// paymentDetail
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: paymentDetail,
        path: paymentDetail,
        pageBuilder: (context, state) {
          final payment = state.extra as PaymentModel;
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => getIt<PaymentDetailCubit>(),
              child: PaymentDetailScreen(payment: payment),
            ),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      /// ticketDetail
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: ticketDetail,
        path: ticketDetail,
        pageBuilder: (context, state) {
          final ticket = state.extra as TicketModel;
          return CustomTransitionPage(
            key: state.pageKey,
            child: TicketDetailScreen(ticket: ticket),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      /// notificationScreen
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: notification,
        path: notification,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => getIt<NotificationCubit>(),
              child: const NotificationScreen(),
            ),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      /// dashboardScreen
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BlocProvider(
            create: (context) => DashboardCubit(getIt()),
            child: DashboardScreen(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                builder: (_, _) => BlocProvider(
                  create: (context) => HomeCubit(movieRepository: getIt()),
                  child: const HomeScreen(),
                ),
                routes: const [],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ticket,
                builder: (_, _) => BlocProvider(
                  create: (context) => TicketCubit(ticketRepository: getIt()),
                  child: const TicketScreen(),
                ),
                routes: const [],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: movie,
                builder: (_, _) => BlocProvider(
                  create: (context) => MovieCubit(movieRepository: getIt()),
                  child: const MovieScreen(),
                ),
                routes: const [],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(path: profile, builder: (_, _) => const ProfileScreen(), routes: const []),
            ],
          ),
        ],
      ),
    ],
  );
}
