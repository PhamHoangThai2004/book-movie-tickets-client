import 'package:client/core/customs/button_custom.dart';
import 'package:client/core/customs/cupertino_button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import '../../core/common/register_cubit.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/size_config/size_config.dart';
import '../../generated/assets.gen.dart';
import 'components/input_email_layout.dart';
import 'components/input_password_layout.dart';
import 'cubit/sign_in_cubit.dart';
import 'cubit/sign_in_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppDimen.of(context);

    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state.status == StatusEnum.success) {
            // Navigate to home or dashboard
            // context.go(AppRoutes.dashboard);
          } else if (state.status == StatusEnum.failure) {
            // Show error message
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'error'.tr())));
          }
        },
        builder: (context, state) {
          return KeyboardDismissOnTap(
            child: Scaffold(
              backgroundColor: AppColors.amberYellow.withValues(alpha: 0.1),
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                      _header(context),
                      VerticalSpacing(of: Dimens.d40.responsive()),
                      InputEmailLayout(),
                      VerticalSpacing(of: Dimens.d25.responsive()),
                      InputPasswordLayout(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'forgot_password'.tr(),
                            style: AppTextStyles.style.w400.s14.amberYellowColor,
                          ),
                        ),
                      ),
                      VerticalSpacing(of: Dimens.d10.responsive()),
                      _buildSignInButton(context, state),
                      VerticalSpacing(of: Dimens.d20.responsive()),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: Dimens.d4.responsive(),
                          children: [
                            Text(
                              'no_account_yet'.tr(),
                              style: AppTextStyles.style.w400.s14.whiteColor,
                            ),
                            CupertinoButtonCustom(
                              onPressed: () => context.pushReplacement(NavigationService.signUp),
                              child: Text(
                                'now_register'.tr(),
                                style: AppTextStyles.style.w700.s14.amberYellowColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButtonCustom(
          onPressed: context.pop,
          child: Assets.svgs.icArrowLeft.svg(
            width: Dimens.d40.responsive(),
            height: Dimens.d40.responsive(),
            colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
        Text('sign_in'.tr(), style: AppTextStyles.style.w700.s28.whiteSmokeColor),
        HorizontalSpacing(of: Dimens.d34.responsive()),
      ],
    );
  }

  Widget _buildSignInButton(BuildContext context, SignInState state) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.isValid != current.isValid,
      builder: (context, state) {
        return ButtonCustom(
          title: 'sign_in'.tr(),
          onPressed: state.isValid ? context.signInCubit.signIn : null,
          titleStyle: state.isValid ? null : AppTextStyles.style.w700.s20.whiteColor,
          buttonStyle: state.isValid ? AppThemes.yellowButtonStyle : AppThemes.disabledButtonStyle,
        );
      },
    );
  }
}
