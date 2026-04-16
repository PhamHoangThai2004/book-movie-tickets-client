import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/data/model/ticket_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/customs/buttons/button_custom.dart';
import 'components/barcode_layout.dart';
import 'components/qr_code_dialog.dart';
import 'components/ticket_detail_info.dart';
import 'components/movie_info_layout.dart';
import 'components/showtime_info_layout.dart';

class TicketDetailScreen extends StatelessWidget {
  final TicketModel ticket;

  const TicketDetailScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: Container(
        decoration: AppThemes.mainBackground,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
            child: Column(
              children: [
                VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                HeaderCustom(title: 'ticket_detail'.tr()),
                VerticalSpacing(of: Dimens.d14.responsive()),
                Container(
                  padding: EdgeInsets.all(Dimens.d24.responsive()),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                  ),
                  child: Column(
                    children: [
                      MovieInfoLayout(movie: ticket.movie),
                      VerticalSpacing(of: Dimens.d24.responsive()),
                      ShowtimeInfoLayout(ticket: ticket),
                      VerticalSpacing(of: Dimens.d16.responsive()),
                      TicketDetailInfo(ticket: ticket),
                      VerticalSpacing(of: Dimens.d16.responsive()),
                      Row(
                        children: [
                          ...List.generate(
                            10,
                            (index) => Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: Dimens.d4.responsive()),
                                child: Container(
                                  color: AppColors.black,
                                  width: Dimens.d3.responsive(),
                                  height: Dimens.d1.responsive(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      VerticalSpacing(of: Dimens.d16.responsive()),
                      BarcodeLayout(ticket: ticket),
                    ],
                  ),
                ),

                VerticalSpacing(of: Dimens.d24.responsive()),

                ButtonCustom(
                  title: 'Lấy mã QR'.tr(),
                  onPressed: () =>
                      showQRCodeDialog(context: context, ticketCode: ticket.ticketCode),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
