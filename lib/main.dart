import 'package:client/core/size_config/device_size_constants.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bot_toast/bot_toast.dart';

import 'core/di/injection.dart';
import 'core/navigation/navigation_service.dart';
import 'core/size_config/app_dimen.dart';
import 'core/size_config/size_config.dart';
import 'data/local/preferences.dart';
import 'data/remote/firebase/fcm_service.dart';

void main() async {
  await _configApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi'),
      startLocale: const Locale('vi'),
      saveLocale: true,
      child: const MyApplication(),
    ),
  );
}

Future<void> _configApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Preferences.instance.init();
  configureDependencies();
  await Firebase.initializeApp();
  await FcmService.initialize();
}

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  Widget build(BuildContext context) {
    AppDimen.of(context);
    SizeConfig().init(context);

    return ScreenUtilInit(
      designSize: const Size(
        DeviceSizeConstants.designDeviceWidth,
        DeviceSizeConstants.designDeviceHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.themData,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: NavigationService.router,
          builder: BotToastInit(),
        );
      },
    );
  }
}
