import 'package:client/core/customs/toasts/shimmer_custom.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/size_config.dart';

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerCustom(
      child: ShimmerLoading(
        isLoading: true,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.d16.responsive(),
            vertical: Dimens.d24.responsive(),
          ),
          decoration: BoxDecoration(color: AppColors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: Dimens.d14.responsive(),
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppColors.coolGray,
                        borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimens.d8.responsive()),
                  Container(
                    height: Dimens.d11.responsive(),
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.coolGray,
                      borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                    ),
                  ),
                ],
              ),
              VerticalSpacing(of: Dimens.d8.responsive()),

              Container(
                height: Dimens.d12.responsive(),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.coolGray,
                  borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                ),
              ),
              VerticalSpacing(of: Dimens.d8.responsive()),

              Container(
                height: Dimens.d12.responsive(),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.coolGray,
                  borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                ),
              ),
              VerticalSpacing(of: Dimens.d8.responsive()),

              Container(
                height: Dimens.d12.responsive(),
                width: 280,
                decoration: BoxDecoration(
                  color: AppColors.coolGray,
                  borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
