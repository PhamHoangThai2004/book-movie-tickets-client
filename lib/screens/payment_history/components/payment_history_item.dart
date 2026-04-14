import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/core/utils/string_utils.dart';
import 'package:client/data/enums/payment_status_enum.dart';
import 'package:client/data/model/payment_preview_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../generated/assets.gen.dart';

class PaymentHistoryItem extends StatelessWidget {
  final PaymentPreviewModel payment;

  const PaymentHistoryItem({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return CupertinoButtonCustom(
      onPressed: () => context.paymentHistoryCubit.getPaymentDetail(payment.id),
      child: Container(
        margin: EdgeInsets.only(bottom: Dimens.d12.responsive()),
        padding: EdgeInsets.symmetric(
          vertical: Dimens.d16.responsive(),
          horizontal: Dimens.d24.responsive(),
        ),
        decoration: BoxDecoration(
          color: AppColors.obsidian,
          borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTimeUtils.fromIso8601(
                    payment.paymentDate ?? payment.createdAt,
                    targetFormat: 'dd/MM/yyyy HH:mm',
                  ),
                  style: AppTextStyles.style.s14.w500.whiteSmokeColor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.d8.responsive(),
                    vertical: Dimens.d4.responsive(),
                  ),
                  decoration: BoxDecoration(
                    color: payment.status.background,
                    borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                  ),
                  child: Text(
                    payment.status.displayStatus,
                    style: AppTextStyles.style.s10.w600.copyWith(color: AppColors.black),
                  ),
                ),
              ],
            ),
            VerticalSpacing(of: Dimens.d12.responsive()),
            _buildInfoRow(Assets.svgs.icWallet, '${'payment_method'.tr()}:', 'vn_pay'.tr()),
            VerticalSpacing(of: Dimens.d12.responsive()),
            _buildInfoRow(
              Assets.svgs.icUsdCircle,
              '${'total_amount'.tr()}:',
              StringUtils.formatVND(payment.totalAmount),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(SvgGenImage icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon.svg(
            width: Dimens.d16.responsive(),
            height: Dimens.d16.responsive(),
            colorFilter: ColorFilter.mode(AppColors.whiteSmoke, BlendMode.srcIn)),
        HorizontalSpacing(of: Dimens.d4.responsive()),
        Text(label, style: AppTextStyles.style.s12.copyWith(color: AppColors.silver)),
        const Spacer(),
        Text(value, style: AppTextStyles.style.s14.w600.copyWith(color: AppColors.amberYellow)),
      ],
    );
  }
}
