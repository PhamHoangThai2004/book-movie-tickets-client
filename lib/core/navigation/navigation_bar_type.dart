// ignore_for_file: constant_identifier_names

import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../generated/assets.gen.dart';

enum NavigationBarType {
  HOME,
  TICKET,
  MOVIE,
  PROFILE;

  static List<NavigationBarType> get bottomNavBarList {
    return [HOME, TICKET, MOVIE, PROFILE];
  }
}

extension NavigationBarTypeX on NavigationBarType {
  int get index {
    switch (this) {
      case NavigationBarType.HOME:
        return 0;
      case NavigationBarType.TICKET:
        return 1;
      case NavigationBarType.MOVIE:
        return 2;
      case NavigationBarType.PROFILE:
        return 3;
    }
  }

  String get title {
    switch (this) {
      case NavigationBarType.HOME:
        return "home".tr();
      case NavigationBarType.TICKET:
        return "ticket".tr();
      case NavigationBarType.MOVIE:
        return "movie".tr();
      case NavigationBarType.PROFILE:
        return "profile".tr();
    }
  }

  Widget get icon {
    switch (this) {
      case NavigationBarType.HOME:
        return Assets.svgs.icHomeOutline.svg(
          width: Dimens.d24.responsive(),
          height: Dimens.d24.responsive(),
          colorFilter: ColorFilter.mode(AppColors.lightGray, BlendMode.srcIn),
        );
      case NavigationBarType.TICKET:
        return Assets.svgs.icTicketOutline.svg(
          width: Dimens.d24.responsive(),
          height: Dimens.d24.responsive(),
          colorFilter: ColorFilter.mode(AppColors.lightGray, BlendMode.srcIn),
        );
      case NavigationBarType.MOVIE:
        return Assets.svgs.icVideoOutline.svg(
          width: Dimens.d24.responsive(),
          height: Dimens.d24.responsive(),
          colorFilter: ColorFilter.mode(AppColors.lightGray, BlendMode.srcIn),
        );
      case NavigationBarType.PROFILE:
        return Assets.svgs.icUserOutline.svg(
          width: Dimens.d24.responsive(),
          height: Dimens.d24.responsive(),
          colorFilter: ColorFilter.mode(AppColors.lightGray, BlendMode.srcIn),
        );
    }
  }

  Widget get iconSelected {
    switch (this) {
      case NavigationBarType.HOME:
        return Assets.svgs.icHome.svg(
          width: Dimens.d24.responsive(),
          height: Dimens.d24.responsive(),
          colorFilter: ColorFilter.mode(AppColors.amberYellow, BlendMode.srcIn),
        );
      case NavigationBarType.TICKET:
        return Assets.svgs.icTicket.svg(
          width: Dimens.d24.responsive(),
          height: Dimens.d24.responsive(),
          colorFilter: ColorFilter.mode(AppColors.amberYellow, BlendMode.srcIn),
        );
      case NavigationBarType.MOVIE:
        return Assets.svgs.icVideo.svg(
          width: Dimens.d24.responsive(),
          height: Dimens.d24.responsive(),
          colorFilter: ColorFilter.mode(AppColors.amberYellow, BlendMode.srcIn),
        );
      case NavigationBarType.PROFILE:
        return Assets.svgs.icUser.svg(
          width: Dimens.d24.responsive(),
          height: Dimens.d24.responsive(),
          colorFilter: ColorFilter.mode(AppColors.amberYellow, BlendMode.srcIn),
        );
    }
  }
}
