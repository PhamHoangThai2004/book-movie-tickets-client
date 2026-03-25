import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/customs/inputs/text_field_custom.dart';
import '../../../generated/assets.gen.dart';
import '../cubit/change_password_cubit.dart';
import '../cubit/change_password_state.dart';

class InputNewPassword extends StatelessWidget {
  final TextEditingController _newPasswordController = TextEditingController();

  InputNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.newPassword != current.newPassword ||
          previous.isNewPasswordVisible != current.isNewPasswordVisible,
      builder: (context, state) {
        return TextFieldCustom(
          controller: _newPasswordController,
          hintText: 'enter_new_password'.tr(),
          labelText: 'new_password'.tr(),
          inputType: state.isNewPasswordVisible
              ? TextInputType.text
              : TextInputType.visiblePassword,
          prefix: Assets.svgs.icPassword,
          suffix: state.isNewPasswordVisible ? Assets.svgs.icEyesOpen : Assets.svgs.icEyesClosed,
          onClickSuffix: context.changePasswordCubit.toggleNewPasswordVisibility,
          errorText: state.newPasswordError,
          onChanged: context.changePasswordCubit.onNewPasswordChanged,
        );
      },
    );
  }
}
