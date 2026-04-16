import 'package:barcode_widget/barcode_widget.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/data/model/ticket_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/size_config.dart';

class BarcodeLayout extends StatelessWidget {
  final TicketModel ticket;

  const BarcodeLayout({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${'order_id'.tr()}: ${ticket.ticketCode}',
          style: AppTextStyles.style.s14.w500.blackColor,
        ),
        VerticalSpacing(of: Dimens.d12.responsive()),
        BarcodeWidget(
          barcode: Barcode.code128(),
          data: ticket.ticketCode,
          width: double.infinity,
          height: Dimens.d100.responsive(),
          drawText: false,
        ),
        VerticalSpacing(of: Dimens.d12.responsive()),
        Text(
          'message_ticket_expired'.tr(
            namedArgs: {
              'expiredAt': DateTimeUtils.fromIso8601(ticket.expiredAt, targetFormat: 'HH:mm dd/MM/yyyy')
            }
          ),
          style: AppTextStyles.style.s14.w500.blackColor,
        ),
      ],
    );
  }
}
