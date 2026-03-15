import 'package:client/core/customs/button_custom.dart';
import 'package:client/core/customs/cupertino_button_custom.dart';
import 'package:client/core/customs/text_field_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/size_config/size_config.dart';
import '../../generated/assets.gen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    AppDimen.of(context);

    return Scaffold(
      backgroundColor: AppColors.amberYellow.withValues(alpha: 0.1),
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        // decoration: AppThemes.mainBackground,
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

                TextFieldCustom(
                  controller: TextEditingController(),
                  hintText: 'enter_your_email'.tr(),
                  errorText: '',
                  prefix: Assets.svgs.icEmail,
                  labelText: 'email'.tr(),
                  inputType: TextInputType.emailAddress,
                  onChanged: (value) {},
                ),
                VerticalSpacing(of: Dimens.d25.responsive()),
                TextFieldCustom(
                  controller: TextEditingController(),
                  hintText: 'enter_your_password'.tr(),
                  labelText: 'password'.tr(),
                  inputType: TextInputType.visiblePassword,
                  prefix: Assets.svgs.icPassword,
                  suffix: Assets.svgs.icEyesClosed,
                  onClickSuffix: () {},
                  errorText: '',
                  onChanged: (value) {},
                ),
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
                SizedBox(height: Dimens.d10.responsive()),
                _buildSignInButton(),
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
                        onPressed: () {},
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
            colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
        Text('sign_in'.tr(), style: AppTextStyles.style.w700.s28.whiteSmokeColor),
        HorizontalSpacing(of: Dimens.d34.responsive()),
      ],
    );
  }

  Widget _buildSignInButton() {
    return ButtonCustom(title: 'sign_in'.tr(), onPressed: () {});
  }
}
