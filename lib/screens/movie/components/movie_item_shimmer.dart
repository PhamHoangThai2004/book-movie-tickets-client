import 'package:client/core/customs/toasts/shimmer_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/size_config.dart';

class MovieItemShimmer extends StatelessWidget {
  const MovieItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
            child: ShimmerLoading(
              isLoading: true,
              child: Container(
                width: double.infinity,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        VerticalSpacing(of: Dimens.d8.responsive()),
        _line(widthFactor: 0.9, height: Dimens.d16.responsive()),
        VerticalSpacing(of: Dimens.d8.responsive()),
        _line(widthFactor: 0.6, height: Dimens.d12.responsive()),
        VerticalSpacing(of: Dimens.d4.responsive()),
        _line(widthFactor: 0.5, height: Dimens.d12.responsive()),
      ],
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
