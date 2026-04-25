import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/dialogs/dialog_custom.dart';
import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/core/utils/app_utils.dart';
import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/core/utils/string_utils.dart';
import 'package:client/data/enums/payment_status_enum.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/model/payment_model.dart';
import 'cubit/payment_detail_cubit.dart';

class PaymentDetailScreen extends StatelessWidget {
  final PaymentModel payment;

  const PaymentDetailScreen({
    super.key,
    required this.payment,
  });

  String _getCleanUrl(String rawUrl) {
    if (rawUrl.contains('VNP_URL=')) {
      return rawUrl.split('VNP_URL=').last;
    }
    return rawUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: Container(
        decoration: AppThemes.mainBackground,
        child: BlocListener<PaymentDetailCubit, PaymentDetailState>(
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            if (state.status.isProcessing) {
              LoadingCustom.show();
            } else if (state.status.isSuccess) {
              LoadingCustom.hideLoading();
              ToastCustom.show(message: 'cancel_payment_success'.tr(), type: ToastType.success);
              context.pop(true);
            } else if (state.status.isFailure) {
              LoadingCustom.hideLoading();
              ToastCustom.show(message: state.errorMessage);
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                  child: HeaderCustom(title: 'payment_detail'.tr()),
                ),
                VerticalSpacing(of: Dimens.d24.responsive()),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.d16.responsive(),
                            vertical: Dimens.d8.responsive(),
                          ),
                          decoration: BoxDecoration(
                            color: payment.status.background.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(Dimens.d64.responsive()),
                          ),
                          child: Text(
                            payment.status.displayStatus,
                            style: AppTextStyles.style.s14.w400.blackColor,
                          ),
                        ),
                        VerticalSpacing(of: Dimens.d24.responsive()),
                        Text(
                          payment.movieName,
                          style: AppTextStyles.style.s18.w700.amberYellowColor,
                        ),
                        VerticalSpacing(of: Dimens.d10.responsive()),
                        Text(
                          '${payment.cinemaName}, ${payment.cinemaAddress}',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.style.s18.w700.whiteColor,
                        ),
                        VerticalSpacing(of: Dimens.d32.responsive()),
                        _buildInfoSection(
                          title: 'transaction_info'.tr(),
                          child: Column(
                            children: [
                              _buildDetailRow('order_id'.tr(), payment.booking.bookingCode),
                              if (payment.transactionId != null)
                                _buildDetailRow('transaction_id'.tr(), payment.transactionId!),
                              _buildDetailRow('payment_method'.tr(), 'vn_pay'.tr()),
                              _buildDetailRow(
                                payment.paymentDate != null
                                    ? 'payment_date'.tr()
                                    : 'payment_created_at'.tr(),
                                payment.paymentDate != null
                                    ? DateTimeUtils.fromIso8601(
                                        payment.paymentDate!,
                                        targetFormat: 'HH:mm dd.MM.yyyy',
                                      )
                                    : DateTimeUtils.fromIso8601(
                                        payment.createdAt,
                                        targetFormat: 'HH:mm dd.MM.yyyy',
                                      ),
                              ),
                            ],
                          ),
                        ),
                        VerticalSpacing(of: Dimens.d16.responsive()),
                        _buildInfoSection(
                          title: 'showtime_info'.tr(),
                          child: Column(
                            children: [
                              if (payment.tickets.isNotEmpty)
                                _buildDetailRow(
                                  'seat'.tr(),
                                  payment.tickets.map((t) => t.seatCode).join(', '),
                                ),
                              _buildDetailRow('movie_name'.tr(), payment.movieName),
                              _buildDetailRow('cinema'.tr(), payment.cinemaName),
                              _buildDetailRow('address'.tr(), payment.cinemaAddress),
                              _buildDetailRow('room'.tr(), payment.showtime.roomName),
                              _buildDetailRow(
                                'showtime'.tr(),
                                '${DateTimeUtils.fromIso8601(payment.showtime.startTime, targetFormat: 'HH:mm')} - ${DateTimeUtils.fromIso8601(payment.showtime.showDate, targetFormat: 'dd.MM.yyyy')}',
                              ),
                            ],
                          ),
                        ),
                        VerticalSpacing(of: Dimens.d24.responsive()),
                        _buildTotalAmount(),
                        VerticalSpacing(of: Dimens.d40.responsive()),
                      ],
                    ),
                  ),
                ),
                if (payment.status.isPending && payment.paymentUrl != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.appDefaultPadding,
                      vertical: Dimens.d8.responsive(),
                    ),
                    child: Row(
                      spacing: Dimens.d8.responsive(),
                      children: [
                        Expanded(
                          child: ButtonCustom(
                            title: 'cancel_payment'.tr(),
                            buttonStyle: AppThemes.outlineButtonStyle,
                            titleStyle: AppTextStyles.style.s20.w700.amberYellowColor,
                            onPressed: () => showDialogCustom(
                              context: context,
                              title: 'confirm'.tr(),
                              message: 'confirm_cancel_payment'.tr(),
                              acceptAction: () =>
                                  context.paymentDetailCubit.cancelPayment(payment.id),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ButtonCustom(
                            title: 'pay'.tr(),
                            onPressed: () => AppUtils.openLink(_getCleanUrl(payment.paymentUrl!)),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.d16.responsive()),
      decoration: BoxDecoration(
        color: AppColors.obsidian,
        borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.style.s14.w700.amberYellowColor),
          VerticalSpacing(of: Dimens.d12.responsive()),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.d8.responsive()),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(label, style: AppTextStyles.style.s14.w400.coolGrayColor)),
          HorizontalSpacing(of: Dimens.d8.responsive()),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyles.style.s14.w500.whiteSmokeColor,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Container(
      padding: EdgeInsets.all(Dimens.d16.responsive()),
      decoration: BoxDecoration(
        color: AppColors.amberYellow.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('total_amount'.tr(), style: AppTextStyles.style.s18.w700.whiteColor),
          Text(
            StringUtils.formatVND(payment.totalAmount),
            style: AppTextStyles.style.s20.w700.amberYellowColor,
          ),
        ],
      ),
    );
  }
}
