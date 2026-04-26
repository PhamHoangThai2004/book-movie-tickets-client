import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:client/screens/notification/components/notification_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/notification_item_shimmer.dart';
import 'cubit/notification_cubit.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.notificationCubit.fetchNotifications();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<NotificationCubit>().state;
    if (state.loadStatus.isProcessing) return;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 500) {
      context.notificationCubit.loadMoreNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: SafeArea(
        child: Container(
          decoration: AppThemes.mainBackground,
          child: BlocListener<NotificationCubit, NotificationState>(
            listenWhen: (p, c) => p.status != c.status,
            listener: (context, state) {
              if (state.status.isProcessing) {
                LoadingCustom.show();
              } else if (state.status.isSuccess) {
                LoadingCustom.hideLoading();
              } else if (state.status.isFailure) {
                LoadingCustom.hideLoading();
                ToastCustom.show(message: state.errorMessage);
              }
            },
            child: Column(
              children: [
                VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                  child: HeaderCustom(
                    title: 'notification'.tr(),
                    extraIcon: Assets.svgs.icCheck,
                    extraAction: context.notificationCubit.markAllSeen,
                  ),
                ),
                VerticalSpacing(of: Dimens.d24.responsive()),
                BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    final notifications = state.items;

                    if (state.loadStatus.isProcessing) {
                      return Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.all(Dimens.d16.responsive()),
                          itemCount: 6,
                          itemBuilder: (_, _) => NotificationItemShimmer(),
                        ),
                      );
                    }

                    if (state.loadStatus.isFailure && notifications.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, size: 64, color: AppColors.silver),
                              SizedBox(height: Dimens.d16.responsive()),
                              Text(
                                state.errorMessage.isEmpty
                                    ? 'error_occurred'.tr()
                                    : state.errorMessage,
                                style: AppTextStyles.style.s16.copyWith(color: AppColors.silver),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: Dimens.d24.responsive()),
                              ButtonCustom(
                                onPressed: () {
                                  context.notificationCubit.fetchNotifications();
                                },
                                width: Dimens.d100.responsive(),
                                title: 'retry'.tr(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (notifications.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'no_notifications'.tr(),
                            style: AppTextStyles.style.s18.w500.whiteColor,
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: RefreshIndicator(
                        color: AppColors.amberYellow,
                        onRefresh: () => context.notificationCubit.fetchNotifications(),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            return NotificationItem(notification: notification);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
