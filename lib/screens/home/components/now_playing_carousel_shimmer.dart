import 'package:flutter/material.dart';

import '../../../core/customs/toasts/shimmer_custom.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/themes/app_colors.dart';

class NowPlayingCarouselShimmer extends StatelessWidget {
  const NowPlayingCarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerCustom(
      child: Column(
        children: [
          SizedBox(
            height: Dimens.d400.responsive(),
            width: Dimens.d310.responsive(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.d8.responsive()),
              child: ShimmerLoading(
                isLoading: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.d20.responsive()),
                  child: Container(color: AppColors.mineShaft),
                ),
              ),
            ),
          ),
          VerticalSpacing(of: Dimens.d20.responsive()),
          ShimmerLoading(
            isLoading: true,
            child: Container(
              height: Dimens.d24.responsive(),
              width: Dimens.d200.responsive(),
              decoration: BoxDecoration(
                color: AppColors.mineShaft,
                borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
              ),
            ),
          ),
          VerticalSpacing(of: Dimens.d8.responsive()),
          ShimmerLoading(
            isLoading: true,
            child: Container(
              height: Dimens.d16.responsive(),
              width: Dimens.d200.responsive(),
              decoration: BoxDecoration(
                color: AppColors.mineShaft,
                borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
              ),
            ),
          ),
          VerticalSpacing(of: Dimens.d8.responsive()),
          ShimmerLoading(
            isLoading: true,
            child: Container(
              height: Dimens.d16.responsive(),
              width: Dimens.d150.responsive(),
              decoration: BoxDecoration(
                color: AppColors.mineShaft,
                borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
              ),
            ),
          ),
          VerticalSpacing(of: Dimens.d16.responsive()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              10,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.d4.responsive()),
                child: ShimmerLoading(
                  isLoading: true,
                  child: Container(
                    width: Dimens.d24.responsive(),
                    height: Dimens.d4.responsive(),
                    decoration: BoxDecoration(
                      color: AppColors.mineShaft,
                      borderRadius: BorderRadius.circular(Dimens.d2.responsive()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
