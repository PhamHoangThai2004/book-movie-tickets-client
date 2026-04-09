import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/utils/string_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/book_tickets_cubit.dart';

class BookingSummary extends StatefulWidget {
  const BookingSummary({super.key});

  @override
  State<StatefulWidget> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  @override
  Widget build(BuildContext context) {
    final double systemPaddingBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      height: Dimens.d90.responsive() + systemPaddingBottom,
      decoration: BoxDecoration(color: AppColors.transparent),
      child: Column(
        children: [
          Divider(color: AppColors.darkCharcoal, thickness: Dimens.d1.responsive()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
            child: BlocBuilder<BookTicketsCubit, BookTicketsState>(
              buildWhen: (p, c) => p.booking != c.booking,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: Dimens.d4.responsive(),
                      children: [
                        Text('total'.tr(), style: AppTextStyles.style.s16.w400.whiteSmokeColor),
                        Text(
                          StringUtils.formatVND(state.booking?.totalAmount ?? 0),
                          style: AppTextStyles.style.s24.w700.amberYellowColor,
                        ),
                      ],
                    ),
                    ButtonCustom(
                      title: 'pay'.tr(),
                      onPressed: () {},
                      width: Dimens.d191.responsive(),
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
