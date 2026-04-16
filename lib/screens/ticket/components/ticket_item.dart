import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/data/model/ticket_preview_model.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../core/customs/images/image_custom.dart';
import '../../../core/size_config/size_config.dart';
import '../../../data/enums/ticket_status_enum.dart';

class TicketItem extends StatelessWidget {
  final TicketPreviewModel ticket;

  const TicketItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return CupertinoButtonCustom(
      onPressed: () => context.ticketCubit.fetchTicketById(ticket.id),
      child: Container(
        margin: EdgeInsets.only(bottom: Dimens.d16.responsive()),
        decoration: BoxDecoration(
          color: AppColors.obsidian,
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.d12.responsive()),
                bottomLeft: Radius.circular(Dimens.d12.responsive()),
              ),
              child: ImageCustom(
                imageUrl: ticket.moviePoster,
                width: Dimens.d111.responsive(),
                height: Dimens.d163.responsive(),
                fit: BoxFit.cover,
                errorWidget: Assets.svgs.icPicture.svg(
                  height: Dimens.d25.responsive(),
                  width: Dimens.d25.responsive(),
                  colorFilter: const ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
                ),
              ),
            ),
            HorizontalSpacing(of: Dimens.d12.responsive()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.movieTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.style.s20.w700.whiteSmokeColor,
                  ),
                  VerticalSpacing(of: Dimens.d8.responsive()),
                  _buildInfoRow(
                    icon: Assets.svgs.icClock.svg(
                      width: Dimens.d16.responsive(),
                      height: Dimens.d16.responsive(),
                    ),
                    text:
                        '${DateTimeUtils.fromIso8601(ticket.showtimeStart, targetFormat: 'HH:mm')} • ${DateTimeUtils.fromIso8601(ticket.showtimeShowDate, targetFormat: 'dd.MM.yyyy')}',
                  ),
                  VerticalSpacing(of: Dimens.d6.responsive()),

                  _buildInfoRow(
                    icon: Assets.svgs.icLocation.svg(
                      width: Dimens.d16.responsive(),
                      height: Dimens.d16.responsive(),
                    ),
                    text: ticket.cinemaName,
                  ),
                  VerticalSpacing(of: Dimens.d8.responsive()),
                  _buildStatusBadge(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required Widget icon, required String text}) {
    return Row(
      children: [
        icon,
        HorizontalSpacing(of: Dimens.d6.responsive()),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.style.s14.w400.whiteSmokeColor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.d8.responsive(),
        vertical: Dimens.d4.responsive(),
      ),
      decoration: BoxDecoration(
        color: ticket.status.background.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
        border: Border.all(color: ticket.status.background, width: 0.5),
      ),
      child: Text(
        ticket.status.title,
        style: AppTextStyles.style.s12.w500.copyWith(color: ticket.status.background),
      ),
    );
  }
}
