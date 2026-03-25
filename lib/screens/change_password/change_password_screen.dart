import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/navigation/navigation_service.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:client/screens/change_password/components/input_old_password.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import 'components/input_new_password.dart';
import 'cubit/change_password_cubit.dart';
import 'cubit/change_password_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.black,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status.isProcessing) {
                LoadingCustom.show();
              } else if (state.status.isSuccess) {
                LoadingCustom.hideLoading();
                ToastCustom.show(message: 'change_password_success'.tr(), type: ToastType.success);
                context.go(NavigationService.auth);
              } else if (state.status.isFailure) {
                LoadingCustom.hideLoading();
                ToastCustom.show(message: state.errorMessage);
              } else {
                LoadingCustom.hideLoading();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                  HeaderCustom(title: 'change_password'.tr()),
                  VerticalSpacing(of: Dimens.d32.responsive()),
                  InputOldPassword(),
                  VerticalSpacing(of: Dimens.d16.responsive()),
                  InputNewPassword(),
                  VerticalSpacing(of: Dimens.d32.responsive()),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.canSubmit != current.canSubmit || previous.status != current.status,
      builder: (context, state) {
        return ButtonCustom(
          title: 'change_password_text'.tr(),
          buttonStyle: state.canSubmit
              ? AppThemes.yellowButtonStyle
              : AppThemes.disabledButtonStyle,
          titleStyle: state.canSubmit
              ? null :AppTextStyles.style.s20.w700.whiteColor,
          onPressed: state.canSubmit ? context.changePasswordCubit.submitChangePassword : null,
        );
      },
    );
  }
}
