import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/customs/inputs/text_field_custom.dart';
import '../../../generated/assets.gen.dart';
import '../cubit/change_password_cubit.dart';
import '../cubit/change_password_state.dart';

class InputOldPassword extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();

  InputOldPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.oldPassword != current.oldPassword ||
          previous.isOldPasswordVisible != current.isOldPasswordVisible,
      builder: (context, state) {
        return TextFieldCustom(
          controller: _oldPasswordController,
          hintText: 'enter_current_password'.tr(),
          labelText: 'current_password'.tr(),
          inputType: state.isOldPasswordVisible
              ? TextInputType.text
              : TextInputType.visiblePassword,
          prefix: Assets.svgs.icPassword,
          suffix: state.isOldPasswordVisible ? Assets.svgs.icEyesOpen : Assets.svgs.icEyesClosed,
          onClickSuffix: context.changePasswordCubit.toggleOldPasswordVisibility,
          errorText: state.oldPasswordError,
          onChanged: context.changePasswordCubit.onOldPasswordChanged,
        );
      },
    );
  }
}
