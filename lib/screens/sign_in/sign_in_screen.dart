import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import '../../core/common/register_cubit.dart';
import '../../core/customs/app_bars/header_custom.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/size_config/size_config.dart';
import '../../data/enums/status_enum.dart';
import 'components/input_email_layout.dart';
import 'components/input_password_layout.dart';
import 'cubit/sign_in_cubit.dart';
import 'cubit/sign_in_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.amberYellow.withValues(alpha: 0.1),
        resizeToAvoidBottomInset: false,
        body: BlocListener<SignInCubit, SignInState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isProcessing) {
              LoadingCustom.show();
            } else if (state.status.isFailure) {
              LoadingCustom.hideLoading();
              ToastCustom.show(message: state.errorMessage);
            } else if (state.status.isSuccess) {
              LoadingCustom.hideLoading();
              context.go(NavigationService.home);
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                  HeaderCustom(title: 'sign_in'.tr()),
                  VerticalSpacing(of: Dimens.d40.responsive()),
                  InputEmailLayout(),
                  VerticalSpacing(of: Dimens.d25.responsive()),
                  InputPasswordLayout(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.push(NavigationService.forgetPassword),
                      child: Text(
                        '${'forgot_password'.tr()}?',
                        style: AppTextStyles.style.w400.s14.amberYellowColor,
                      ),
                    ),
                  ),
                  VerticalSpacing(of: Dimens.d10.responsive()),
                  _buildSignInButton(context),
                  VerticalSpacing(of: Dimens.d20.responsive()),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: Dimens.d4.responsive(),
                      children: [
                        Text('no_account_yet'.tr(), style: AppTextStyles.style.w400.s14.whiteColor),
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
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
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
