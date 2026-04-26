import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/navigation/navigation_service.dart';
import 'package:client/core/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_colors.dart';
import '../../../generated/assets.gen.dart';
import '../../dashboard/cubit/dashboard_cubit.dart';

class HomeHeaderLayout extends StatelessWidget {
  const HomeHeaderLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<DashboardCubit, DashboardState>(
          buildWhen: (previous, current) => previous.userInfo?.name != current.userInfo?.name,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'hello'.tr(namedArgs: {'fullName': state.userInfo?.name ?? ''}),
                  style: AppTextStyles.style.s18.w400.whiteSmokeColor,
                ),
                Text('welcome_back'.tr(), style: AppTextStyles.style.s26.w700.whiteSmokeColor),
              ],
            );
          },
        ),
        Stack(
          children: [
            CupertinoButtonCustom(
              onPressed: () {
                if (AppUtils.isLoggedIn()) {
                  context.pushNamed(NavigationService.notification);
                } else {
                  AppUtils.requestLogin(context: context);
                }
              },
              child: Assets.svgs.icNotification.svg(
                width: Dimens.d36.responsive(),
                height: Dimens.d36.responsive(),
                colorFilter: const ColorFilter.mode(AppColors.whiteSmoke, BlendMode.srcIn),
              ),
            ),
            BlocBuilder<DashboardCubit, DashboardState>(
              buildWhen: (previous, current) =>
                  previous.haveUnreadNotifications != current.haveUnreadNotifications,
              builder: (context, state) {
                if (!state.haveUnreadNotifications) {
                  return const SizedBox.shrink();
                }
                return Positioned(
                  right: 5,
                  top: 3,
                  child: Container(
                    width: Dimens.d10.responsive(),
                    height: Dimens.d10.responsive(),
                    decoration: BoxDecoration(
                      color: AppColors.neonGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.warmBlack),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
