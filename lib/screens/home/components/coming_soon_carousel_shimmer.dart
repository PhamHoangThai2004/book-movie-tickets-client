import 'package:flutter/material.dart';

import '../../../core/customs/toasts/shimmer_custom.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/themes/app_colors.dart';

class ComingSoonCarouselShimmer extends StatelessWidget {
  const ComingSoonCarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerCustom(
      child: SizedBox(
        height: Dimens.d360.responsive(),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: Dimens.d16.responsive()),
              child: ShimmerLoading(
                isLoading: true,
                child: SizedBox(
                  width: Dimens.d191.responsive(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
                          child: Container(
                            color: AppColors.mineShaft,
                          ),
                        ),
                      ),
                      VerticalSpacing(of: Dimens.d8.responsive()),
                      Container(
                        height: Dimens.d16.responsive(),
                        color: AppColors.mineShaft,
                      ),
                      VerticalSpacing(of: Dimens.d8.responsive()),
                      Container(
                        height: Dimens.d12.responsive(),
                        width: Dimens.d100.responsive(),
                        color: AppColors.mineShaft,
                      ),
                      VerticalSpacing(of: Dimens.d4.responsive()),
                      Container(
                        height: Dimens.d12.responsive(),
                        width: Dimens.d80.responsive(),
                        color: AppColors.mineShaft,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

