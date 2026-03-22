import 'package:client/core/navigation/navigation_service.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../generated/assets.gen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupState();
}

class _StartupState extends State<StartupScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    context.go(NavigationService.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.d8.responsive())),
          child: Assets.images.appLogo.image(
            width: Dimens.d80.responsive(),
            height: Dimens.d80.responsive(),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
