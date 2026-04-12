import 'package:client/core/customs/toasts/shimmer_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/size_config.dart';

class PaymentLoadingShimmer extends StatelessWidget {
  const PaymentLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerCustom(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Info Card
          Container(
            decoration: BoxDecoration(
              color: AppColors.obsidian,
              borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimens.d16.responsive()),
                    topLeft: Radius.circular(Dimens.d16.responsive()),
                  ),
                  child: ShimmerLoading(
                    isLoading: true,
                    child: Container(
                      width: Dimens.d120.responsive(),
                      height: Dimens.d161.responsive(),
                      color: AppColors.white,
                    ),
                  ),
                ),
                HorizontalSpacing(of: Dimens.d16.responsive()),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLine(height: Dimens.d20.responsive()),
                      VerticalSpacing(of: Dimens.d8.responsive()),
                      SizedBox(width: 150, child: _buildLine(height: Dimens.d12.responsive())),
                      VerticalSpacing(of: Dimens.d8.responsive()),
                      SizedBox(width: 200, child: _buildLine(height: Dimens.d12.responsive())),
                      VerticalSpacing(of: Dimens.d8.responsive()),
                      SizedBox(width: 150, child: _buildLine(height: Dimens.d12.responsive())),
                    ],
                  ),
                ),
              ],
            ),
          ),
          VerticalSpacing(of: Dimens.d24.responsive()),

          // Order Info
          SizedBox(width: 80, child: _buildLine(height: Dimens.d16.responsive())),
          VerticalSpacing(of: Dimens.d12.responsive()),
          _buildLine(height: Dimens.d16.responsive()),
          VerticalSpacing(of: Dimens.d12.responsive()),
          _buildLine(height: Dimens.d16.responsive()),
          VerticalSpacing(of: Dimens.d14.responsive()),

          // Divider
          ShimmerLoading(
            isLoading: true,
            child: Container(height: Dimens.d1.responsive(), color: AppColors.white),
          ),
          VerticalSpacing(of: Dimens.d14.responsive()),

          // Total Section
          _buildLine(height: Dimens.d24.responsive()),
          VerticalSpacing(of: Dimens.d24.responsive()),

          // Payment Method Label
          SizedBox(width: 100, child: _buildLine(height: Dimens.d18.responsive())),
          VerticalSpacing(of: Dimens.d16.responsive()),

          // Payment Method Card
          Container(
            padding: EdgeInsets.all(Dimens.d16.responsive()),
            decoration: BoxDecoration(
              color: AppColors.obsidian,
              borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
            ),
            child: Row(
              children: [
                ShimmerLoading(
                  isLoading: true,
                  child: Container(
                    width: Dimens.d60.responsive(),
                    height: Dimens.d40.responsive(),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                    ),
                  ),
                ),
                HorizontalSpacing(of: Dimens.d16.responsive()),
                Expanded(child: _buildLine(height: Dimens.d16.responsive())),
              ],
            ),
          ),
          VerticalSpacing(of: Dimens.d24.responsive()),
        ],
      ),
    );
  }

  Widget _buildLine({required double height}) {
    return ShimmerLoading(
      isLoading: true,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
        ),
      ),
    );
  }
}
