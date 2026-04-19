import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/customs/dialogs/dialog_custom.dart';
import 'package:client/core/navigation/navigation_service.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/core/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../generated/assets.gen.dart';
import '../dashboard/cubit/dashboard_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isFaceIdEnabled = true;

  @override
  Widget build(BuildContext context) {
    AppDimen.of(context);

    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: Container(
        height: SizeConfig.screenHeight,
        decoration: AppThemes.mainBackground,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Dimens.d20.responsive()),
                        _buildHeader(),
                        SizedBox(height: Dimens.d60.responsive()),
                        _buildMenuItem(
                          icon: Assets.svgs.icShoppingCart.svg(
                            width: Dimens.d32.responsive(),
                            height: Dimens.d32.responsive(),
                            colorFilter: ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
                          ),
                          title: 'payment_history'.tr(),
                          onTap: () => context.pushNamed(NavigationService.paymentHistory),
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Assets.svgs.icLock.svg(
                            width: Dimens.d32.responsive(),
                            height: Dimens.d32.responsive(),
                            colorFilter: ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
                          ),
                          title: 'change_password'.tr(),
                          onTap: () => context.pushNamed(NavigationService.changePassword),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimens.d16.responsive()),
                _buildLogoutButton(),
                SizedBox(height: Dimens.d20.responsive()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      buildWhen: (previous, current) => previous.userInfo != current.userInfo,
      builder: (context, state) {
        return Row(
          children: [
            CircleAvatar(
              radius: Dimens.d45.responsive(),
              backgroundImage: const NetworkImage('https://i.pravatar.cc/300'),
            ),
            HorizontalSpacing(of: Dimens.d16.responsive()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.userInfo?.name ?? '',
                    style: AppTextStyles.style.whiteSmokeColor.s32.w700,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  VerticalSpacing(of: Dimens.d4.responsive()),
                  Row(
                    children: [
                      Assets.svgs.icCall.svg(
                        width: Dimens.d20.responsive(),
                        height: Dimens.d20.responsive(),
                        colorFilter: ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
                      ),
                      HorizontalSpacing(of: Dimens.d8.responsive()),
                      Text(
                        state.userInfo?.phoneNumber ?? 'not_yet'.tr(),
                        style: AppTextStyles.style.silverColor.s14.w400,
                      ),
                    ],
                  ),
                  VerticalSpacing(of: Dimens.d4.responsive()),
                  Row(
                    children: [
                      Assets.svgs.icEmail.svg(
                        width: Dimens.d20.responsive(),
                        height: Dimens.d20.responsive(),
                        colorFilter: ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
                      ),
                      HorizontalSpacing(of: Dimens.d8.responsive()),
                      Expanded(
                        child: Text(
                          state.userInfo?.email ?? '',
                          style: AppTextStyles.style.silverColor.s14.w400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => context.pushNamed(NavigationService.updateProfile),
              icon: Assets.svgs.icEdit.svg(
                width: Dimens.d24.responsive(),
                height: Dimens.d24.responsive(),
                colorFilter: ColorFilter.mode(AppColors.whiteSmoke, BlendMode.srcIn),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuItem({
    required Widget icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return CupertinoButtonCustom(
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimens.d16.responsive()),
        child: Row(
          children: [
            icon,
            HorizontalSpacing(of: Dimens.d16.responsive()),
            Expanded(child: Text(title, style: AppTextStyles.style.whiteSmokeColor.s16.w700)),
            Assets.svgs.icArrowRight.svg(
              width: Dimens.d24.responsive(),
              height: Dimens.d24.responsive(),
              colorFilter: ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.darkGray, height: 0.5, thickness: 0.5);
  }

  Widget _buildLogoutButton() {
    return CupertinoButtonCustom(
      onPressed: () => showDialogCustom(
        context: context,
        title: 'sign_out'.tr(),
        message: 'confirm_logout_message'.tr(),
        acceptAction: () => AppUtils.logout(context),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: Dimens.d14.responsive()),
        decoration: AppThemes.outlineButtonStyle.copyWith(
          border: Border.all(color: AppColors.amberYellow, width: Dimens.d1.responsive()),
        ),
        alignment: Alignment.center,
        child: Text('sign_out'.tr(), style: AppTextStyles.style.s20.w700.amberYellowColor),
      ),
    );
  }
}
