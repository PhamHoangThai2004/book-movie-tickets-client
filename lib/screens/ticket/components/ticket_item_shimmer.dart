import 'package:client/core/customs/toasts/shimmer_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/size_config.dart';

class TicketItemShimmer extends StatelessWidget {
  const TicketItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimens.d16.responsive()),
      decoration: BoxDecoration(
        color: AppColors.darkCharcoal,
        borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
            child: ShimmerLoading(
              isLoading: true,
              child: Container(
                width: Dimens.d80.responsive(),
                height: Dimens.d120.responsive(),
                color: AppColors.white,
              ),
            ),
          ),
          HorizontalSpacing(of: Dimens.d12.responsive()),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _line(widthFactor: 0.8, height: Dimens.d16.responsive()),
                VerticalSpacing(of: Dimens.d8.responsive()),
                _line(widthFactor: 0.6, height: Dimens.d12.responsive()),
                VerticalSpacing(of: Dimens.d8.responsive()),
                _line(widthFactor: 0.7, height: Dimens.d12.responsive()),
                VerticalSpacing(of: Dimens.d8.responsive()),
                _line(widthFactor: 0.5, height: Dimens.d12.responsive()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _line({required double widthFactor, required double height}) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ShimmerLoading(
        isLoading: true,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
          ),
        ),
      ),
    );
  }
}
