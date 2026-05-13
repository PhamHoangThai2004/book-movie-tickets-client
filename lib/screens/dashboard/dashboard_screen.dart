import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/utils/app_utils.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:client/screens/dashboard/components/navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/customs/toasts/loading_custom.dart';
import '../../core/navigation/navigation_bar_type.dart';
import '../../core/size_config/size_config.dart';
import '../../core/themes/app_colors.dart';
import '../../data/local/preferences.dart';
import '../../data/remote/firebase/fcm_service.dart';
import 'cubit/dashboard_cubit.dart';

class DashboardScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() => _DashboardState();

  const DashboardScreen({super.key, required this.navigationShell});
}

class _DashboardState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.dashboardCubit.getUserInfo();
    if (AppUtils.isLoggedIn()) {
      context.dashboardCubit.checkHaveUnreadNotifications();
    }
    FcmService.listenerFirebaseMessaging();
    _addDeviceToken();
  }

  @override
  void didUpdateWidget(covariant DashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final state = context.dashboardCubit.state;

    if (state.userInfo == null) {
      context.dashboardCubit.getUserInfo();
    }

    if (!state.deviceTokenAdded && AppUtils.isLoggedIn()) {
      _addDeviceToken();
    }
  }

  void _addDeviceToken() {
    FcmService.getFCMToken((token) {
      if (!mounted) return;
      context.dashboardCubit.addDeviceToken(token);
      Preferences.instance.saveDeviceToken(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardCubit, DashboardState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isProcessing) {
          LoadingCustom.show();
        } else {
          LoadingCustom.hideLoading();
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.black,
        resizeToAvoidBottomInset: false,
        body: widget.navigationShell,
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    final double systemPaddingBottom = MediaQuery.of(context).padding.bottom;
    final bottomNavigationList = NavigationBarType.bottomNavBarList;

    return Container(
      height: Dimens.d90.responsive() + systemPaddingBottom,
      padding: EdgeInsets.only(
        bottom: systemPaddingBottom > 0 ? systemPaddingBottom : Dimens.d10.responsive(),
      ),
      child: Column(
        children: [
          Divider(color: AppColors.darkCharcoal, thickness: Dimens.d1.responsive()),
          VerticalSpacing(of: Dimens.d10.responsive()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: bottomNavigationList.asMap().entries.map((entry) {
              NavigationBarType item = entry.value;

              return NavigationBarItem(
                type: item,
                isSelected: item.index == widget.navigationShell.currentIndex,
                onTap: () => _goToTab(item.index),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _goToTab(int index) {
    final loggedIn = AppUtils.isLoggedIn();
    if (index == 0 && loggedIn) {
      context.dashboardCubit.checkHaveUnreadNotifications();
    }
    if (index == 1 || index == 3) {
      if (!loggedIn) {
        AppUtils.requestLogin(context: context);
        return;
      }
    }

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
