import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/data/model/ticket_model.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class ShowtimeInfoLayout extends StatelessWidget {
  final TicketModel ticket;

  const ShowtimeInfoLayout({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoItem(
          icon: Assets.svgs.icCalendar,
          title: DateTimeUtils.fromIso8601(ticket.showtime.startTime, targetFormat: "HH:mm"),
          subtitle: DateTimeUtils.fromIso8601(ticket.showtime.showDate, targetFormat: "dd.MM.yyyy"),
        ),
        _buildInfoItem(
          icon: Assets.svgs.icSeat,
          title: ticket.room.name,
          subtitle: ticket.seat.seatCode,
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required SvgGenImage icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon.svg(
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          width: Dimens.d48.responsive(),
          height: Dimens.d48.responsive(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.style.s16.w500.blackColor),
            Text(subtitle, style: AppTextStyles.style.s16.w500.blackColor),
          ],
        ),
      ],
    );
  }
}
