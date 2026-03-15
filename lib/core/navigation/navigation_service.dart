import 'package:client/screens/auth/auth_screen.dart';
import 'package:client/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/movie/movie_screen.dart';
import 'package:client/screens/profile/profile_screen.dart';
import 'package:client/screens/sign_in/sign_in_screen.dart';
import 'package:client/screens/sign_up/sign_up_screen.dart';
import 'package:client/screens/startup/startup_screen.dart';
import 'package:client/screens/ticket/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../screens/dashboard/dashboard_screen.dart';

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
          child: const AuthScreen(),
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
          child: const SignUpScreen(),
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
          child: const SignInScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      /// dashboardScreen
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BlocProvider(
            create: (context) => DashboardCubit(),
            child: DashboardScreen(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: home, builder: (_, _) => HomeScreen(), routes: const [])],
          ),

          StatefulShellBranch(
            routes: [GoRoute(path: ticket, builder: (_, _) => TicketScreen(), routes: const [])],
          ),

          StatefulShellBranch(
            routes: [GoRoute(path: movie, builder: (_, _) => MovieScreen(), routes: const [])],
          ),

          StatefulShellBranch(
            routes: [GoRoute(path: profile, builder: (_, _) => ProfileScreen(), routes: const [])],
          ),
        ],
      ),
    ],
  );
}
