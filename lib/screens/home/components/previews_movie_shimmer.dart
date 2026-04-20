import 'package:client/core/customs/toasts/shimmer_custom.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/themes/app_colors.dart';

class PreviewsMovieShimmer extends StatelessWidget {
  const PreviewsMovieShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerCustom(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimens.d220.responsive(),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: Dimens.d16.responsive()),
                  child: ShimmerLoading(
                    isLoading: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Dimens.d160.responsive(),
                          height: Dimens.d150.responsive(),
                          decoration: BoxDecoration(
                            color: AppColors.darkGray,
                            borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
                          ),
                        ),
                        VerticalSpacing(of: Dimens.d8.responsive()),
                        Container(
                          width: Dimens.d160.responsive(),
                          height: Dimens.d14.responsive(),
                          decoration: BoxDecoration(
                            color: AppColors.darkGray,
                            borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                          ),
                        ),
                        VerticalSpacing(of: Dimens.d4.responsive()),
                        Container(
                          width: Dimens.d120.responsive(),
                          height: Dimens.d12.responsive(),
                          decoration: BoxDecoration(
                            color: AppColors.darkGray,
                            borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          VerticalSpacing(of: Dimens.d20.responsive()),
        ],
      ),
    );
  }
}
