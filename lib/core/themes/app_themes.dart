import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../size_config/app_dimen.dart';
import '../size_config/dimens.dart';

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
      colors: [AppColors.warmBlack, AppColors.deepBrown.withValues(alpha: 0.2)],
      stops: [0.5, 1.2],
    ),
  );

  static BoxDecoration yellowButtonStyle = BoxDecoration(
    color: AppColors.amberYellow,
    borderRadius: BorderRadius.all(Radius.circular(Dimens.d64.responsive())),
  );

  static BoxDecoration disabledButtonStyle = BoxDecoration(
    color: AppColors.grey,
    borderRadius: BorderRadius.all(Radius.circular(Dimens.d64.responsive())),
  );

  static BoxDecoration outlineButtonStyle = BoxDecoration(
    color: AppColors.transparent,
    border: Border.all(color: AppColors.whiteSmoke, width: Dimens.d1.responsive()),
    borderRadius: BorderRadius.all(Radius.circular(Dimens.d64.responsive())),
  );

  static OutlineInputBorder inputDefaultBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.transparent),
    borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
  );

  static OutlineInputBorder inputErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.red),
    borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
  );

  static OutlineInputBorder inputFocusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.amberYellow),
    borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
  );
}
