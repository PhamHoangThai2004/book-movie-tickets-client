import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/customs/app_bars/header_custom.dart';
import '../../../core/customs/buttons/button_custom.dart';
import '../../../core/customs/buttons/cupertino_button_custom.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_themes.dart';
import '../cubit/sign_up_cubit.dart';
import '../cubit/sign_up_state.dart';
import 'input_register_email.dart';
import 'input_register_name.dart';
import 'input_register_password.dart';

class RegisterFormLayout extends StatelessWidget {
  const RegisterFormLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
        HeaderCustom(title: 'sign_up'.tr()),
        VerticalSpacing(of: Dimens.d40.responsive()),
        InputRegisterName(),
        VerticalSpacing(of: Dimens.d20.responsive()),
        InputRegisterEmail(),
        VerticalSpacing(of: Dimens.d20.responsive()),
        InputRegisterPassword(),
        VerticalSpacing(of: Dimens.d30.responsive()),
        _buildSignUpButton(),
        VerticalSpacing(of: Dimens.d20.responsive()),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: Dimens.d4.responsive(),
            children: [
              Text('already_have_account'.tr(), style: AppTextStyles.style.w400.s14.whiteColor),
              CupertinoButtonCustom(
                onPressed: () => context.pushReplacement(NavigationService.signIn),
                child: Text('sign_in'.tr(), style: AppTextStyles.style.w700.s14.amberYellowColor),
              ),
            ],
          ),
        ),
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
