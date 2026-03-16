import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/button_custom.dart';
import 'package:client/core/customs/cupertino_button_custom.dart';
import 'package:client/core/navigation/navigation_service.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/screens/sign_up/components/input_email_layout.dart';
import 'package:client/screens/sign_up/components/input_name_layout.dart';
import 'package:client/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:client/screens/sign_up/cubit/sign_up_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/size_config/size_config.dart';
import '../../core/themes/app_themes.dart';
import '../../generated/assets.gen.dart';
import 'components/input_password_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    AppDimen.of(context);

    return Scaffold(
      backgroundColor: AppColors.amberYellow.withValues(alpha: 0.1),
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: SizeConfig.screenHeight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                _header(),
                VerticalSpacing(of: Dimens.d40.responsive()),
                InputNameLayout(),
                VerticalSpacing(of: Dimens.d20.responsive()),
                InputEmailLayout(),
                VerticalSpacing(of: Dimens.d20.responsive()),
                InputPasswordLayout(),
                VerticalSpacing(of: Dimens.d30.responsive()),
                _buildSignUpButton(),
                VerticalSpacing(of: Dimens.d20.responsive()),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: Dimens.d4.responsive(),
                    children: [
                      Text(
                        'already_have_account'.tr(),
                        style: AppTextStyles.style.w400.s14.whiteColor,
                      ),
                      CupertinoButtonCustom(
                        onPressed: () => context.pushReplacement(NavigationService.signIn),
                        child: Text(
                          'sign_in'.tr(),
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
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButtonCustom(
          onPressed: context.pop,
          child: Assets.svgs.icArrowLeft.svg(
            width: Dimens.d40.responsive(),
            height: Dimens.d40.responsive(),
            colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
        Text('sign_up'.tr(), style: AppTextStyles.style.w700.s28.whiteSmokeColor),
        HorizontalSpacing(of: Dimens.d34.responsive()),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.isValid != current.isValid,
      builder: (context, state) {
        return ButtonCustom(
          title: 'sign_up'.tr(),
          onPressed: state.isValid ? context.signUpCubit.signUp : null,
          titleStyle: state.isValid ? null : AppTextStyles.style.w700.s20.whiteColor,
          buttonStyle: state.isValid ? AppThemes.yellowButtonStyle : AppThemes.disabledButtonStyle,
        );
      },
    );
  }
}
