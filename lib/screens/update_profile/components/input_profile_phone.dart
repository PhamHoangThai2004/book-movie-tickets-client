import 'package:client/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:client/screens/update_profile/cubit/update_profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/customs/inputs/text_field_custom.dart';
import '../../../generated/assets.gen.dart';

class InputProfilePhone extends StatelessWidget {
  final TextEditingController phoneController;

  const InputProfilePhone({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextFieldCustom(
          controller: phoneController,
          hintText: 'enter_your_phone_number'.tr(),
          errorText: state.phoneNumberError,
          prefix: Assets.svgs.icCall,
          labelText: 'phone_number'.tr(),
          inputType: TextInputType.phone,
          onChanged: context.updateProfileCubit.onPhoneNumberChanged,
        );
      },
    );
  }
}
