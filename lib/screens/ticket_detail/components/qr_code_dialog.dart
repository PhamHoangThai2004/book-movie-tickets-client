import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/size_config/app_dimen.dart';
import '../../../generated/assets.gen.dart';

Future<void> showQRCodeDialog({required BuildContext context, required String ticketCode}) async {
  await showDialog(
    context: context,
    barrierColor: AppColors.black.withValues(alpha: 0.5),
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) => _TicketDetailQRCode(ticketCode: ticketCode),
  );
}

class _TicketDetailQRCode extends StatelessWidget {
  final String ticketCode;

  const _TicketDetailQRCode({required this.ticketCode});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.d16.responsive(),
          vertical: Dimens.d24.responsive(),
        ),
        decoration: BoxDecoration(
          color: AppColors.darkCharcoal,
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButtonCustom(
                onPressed: () => context.pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(Dimens.d12.responsive()),
                  child: Assets.svgs.icClose.svg(),
                ),
              ),
            ),
            SizedBox(height: Dimens.d12.responsive()),
            Center(
              child: Container(
                padding: EdgeInsets.all(Dimens.d12.responsive()),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                ),
                child: QrImageView(
                  data: ticketCode,
                  version: QrVersions.auto,
                  size: Dimens.d200.responsive(),
                ),
              ),
            ),
            SizedBox(height: Dimens.d16.responsive()),
            Text(
              'note_ticket'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.style.s12.w400.whiteSmokeColor,
            ),
          ],
        ),
      ),
    );
  }
}
