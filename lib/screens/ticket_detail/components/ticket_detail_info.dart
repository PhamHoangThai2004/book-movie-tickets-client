import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/utils/string_utils.dart';
import 'package:client/data/enums/seat_type_enum.dart';
import 'package:client/data/model/ticket_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/size_config.dart';
import '../../../generated/assets.gen.dart';

class TicketDetailInfo extends StatelessWidget {
  final TicketModel ticket;

  const TicketDetailInfo({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: AppColors.black, thickness: 0.5),
        VerticalSpacing(of: Dimens.d16.responsive()),
        Row(
          children: [
            Assets.svgs.icMoneySend.svg(
              width: Dimens.d24.responsive(),
              height: Dimens.d24.responsive(),
              colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
            ),
            HorizontalSpacing(of: Dimens.d12.responsive()),
            Text(
              StringUtils.formatVND(ticket.price),
              style: AppTextStyles.style.s16.w600.blackColor,
            ),
            HorizontalSpacing(of: Dimens.d12.responsive()),
            if (ticket.seat.seatType.isVip)
              Assets.svgs.icLabelVip.svg()
          ],
        ),
        VerticalSpacing(of: Dimens.d16.responsive()),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.svgs.icLocation.svg(
              width: Dimens.d24.responsive(),
              height: Dimens.d24.responsive(),
              colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
            ),
            HorizontalSpacing(of: Dimens.d12.responsive()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ticket.cinema.name, style: AppTextStyles.style.s16.w600.blackColor),
                  VerticalSpacing(of: Dimens.d4.responsive()),
                  Text(ticket.cinema.address, style: AppTextStyles.style.s14.w500.blackColor),
                ],
              ),
            ),
          ],
        ),
        VerticalSpacing(of: Dimens.d12.responsive()),
        Row(
          children: [
            Assets.svgs.icNote.svg(
              width: Dimens.d24.responsive(),
              height: Dimens.d24.responsive(),
              colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
            ),
            HorizontalSpacing(of: Dimens.d12.responsive()),
            Expanded(
              child: Text('note_ticket'.tr(), style: AppTextStyles.style.s14.w400.blackColor),
            ),
          ],
        ),
      ],
    );
  }
}
