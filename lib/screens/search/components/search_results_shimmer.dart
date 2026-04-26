import 'package:client/core/customs/toasts/shimmer_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SearchResultsShimmer extends StatelessWidget {
  const SearchResultsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerCustom(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Dimens.d16.responsive(),
            mainAxisSpacing: Dimens.d20.responsive(),
            childAspectRatio: 0.6,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return _buildShimmerItem();
          },
        ),
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.mineShaft,
              borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
            ),
          ),
        ),
        VerticalSpacing(of: Dimens.d8.responsive()),
        Container(
          height: Dimens.d16.responsive(),
          decoration: BoxDecoration(
            color: AppColors.mineShaft,
            borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
          )
        ),
        VerticalSpacing(of: Dimens.d4.responsive()),
        Container(
          height: Dimens.d12.responsive(),
          width: double.infinity * 0.7,
          decoration: BoxDecoration(
            color: AppColors.mineShaft,
            borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
          )
        ),
        VerticalSpacing(of: Dimens.d4.responsive()),
        Container(
          height: Dimens.d12.responsive(),
          width: double.infinity * 0.5,
          decoration: BoxDecoration(
            color: AppColors.mineShaft,
            borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
          )
        ),
      ],
    );
  }
}

