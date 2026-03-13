import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppThemes {
  static ThemeData themData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static BoxDecoration mainBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.center,
      end: Alignment.bottomLeft,
      colors: [AppColors.black, AppColors.black, AppColors.amberYellow.withValues(alpha: 0.2)],
      stops: [0.0, 0.6, 1.0],
    ),
  );
}
