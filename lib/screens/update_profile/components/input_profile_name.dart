import 'package:client/screens/update_profile/cubit/update_profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/customs/inputs/text_field_custom.dart';
import '../../../generated/assets.gen.dart';
import '../cubit/update_profile_cubit.dart';

class InputProfileName extends StatelessWidget {
  final TextEditingController nameController;

  const InputProfileName({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFieldCustom(
          controller: nameController,
          hintText: 'enter_your_name'.tr(),
          errorText: state.nameError,
          prefix: Assets.svgs.icEdit,
          labelText: 'full_name'.tr(),
          inputType: TextInputType.name,
          onChanged: context.updateProfileCubit.onNameChanged,
        );
      },
    );
  }
}
