import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../core/customs/toasts/shimmer_custom.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/size_config.dart';

class PaymentHistoryItemShimmer extends StatelessWidget {
  const PaymentHistoryItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Date and Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading(
                isLoading: true,
                child: Container(
                  height: Dimens.d14.responsive(),
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                  ),
                ),
              ),
              ShimmerLoading(
                isLoading: true,
                child: Container(
                  height: Dimens.d20.responsive(),
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                  ),
                ),
              ),
            ],
          ),
          VerticalSpacing(of: Dimens.d12.responsive()),
          // Payment Method Row
          Row(
            children: [
              ShimmerLoading(
                isLoading: true,
                child: Container(
                  height: Dimens.d16.responsive(),
                  width: Dimens.d16.responsive(),
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                  ),
                ),
              ),
              HorizontalSpacing(of: Dimens.d8.responsive()),
              Expanded(
                child: ShimmerLoading(
                  isLoading: true,
                  child: Container(
                    height: Dimens.d12.responsive(),
                    decoration: BoxDecoration(
                      color: AppColors.darkGray,
                      borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                    ),
                  ),
                ),
              ),
            ],
          ),
          VerticalSpacing(of: Dimens.d12.responsive()),
          // Amount Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading(
                isLoading: true,
                child: Container(
                  height: Dimens.d12.responsive(),
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                  ),
                ),
              ),
              ShimmerLoading(
                isLoading: true,
                child: Container(
                  height: Dimens.d14.responsive(),
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

