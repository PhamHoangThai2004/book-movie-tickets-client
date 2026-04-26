import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/data/remote/firebase/fcm_service.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/date_time_utils.dart';
import '../../../data/model/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final isSeen = notification.seenAt != null;

    return Column(
      children: [
        CupertinoButtonCustom(
          onPressed: () => FcmService.openDetail(notification),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.d16.responsive(),
              vertical: Dimens.d24.responsive(),
            ),
            decoration: BoxDecoration(
              color: isSeen ? AppColors.transparent : AppColors.amberYellow.withValues(alpha: 0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppTextStyles.style.s14.w700.copyWith(
                          color: isSeen ? AppColors.whiteSmoke : AppColors.amberYellow,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: Dimens.d8.responsive()),
                    Text(
                      DateTimeUtils.fromIso8601(
                        notification.createdAt,
                        targetFormat: 'HH:mm dd/MM/yyyy',
                      ),
                      style: AppTextStyles.style.s11.w400.coolGrayColor,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                VerticalSpacing(of: Dimens.d8.responsive()),

                Text(
                  notification.content,
                  style: AppTextStyles.style.s13.w400.coolGrayColor,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        // Divider(
        //   height: Dimens.d1.responsive(),
        //   color: AppColors.amberYellow.withValues(alpha: 0.1),
        //   indent: Dimens.d16.responsive(),
        //   endIndent: Dimens.d16.responsive(),
        // ),
      ],
    );
  }
}
