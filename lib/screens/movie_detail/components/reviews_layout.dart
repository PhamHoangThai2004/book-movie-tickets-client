import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:client/screens/movie_detail/components/review_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/size_config/size_config.dart';
import '../cubit/movie_detail_cubit.dart';

class ReviewsLayout extends StatelessWidget {
  const ReviewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('review'.tr(), style: AppTextStyles.style.s24.w700.whiteColor),
        BlocBuilder<MovieDetailCubit, MovieDetailState>(
          buildWhen: (previous, current) =>
              previous.reviewsStatus != current.reviewsStatus &&
              previous.reviews != current.reviews,
          builder: (context, state) {
            if (state.reviewsStatus.isProcessing) {
              return _buildReviewsLoading();
            }
            if (state.reviews == null || state.reviews!.items.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimens.d20.responsive()),
                  child: Text(
                    'movie_not_reviews'.tr(),
                    style: AppTextStyles.style.s14.w400.coolGrayColor,
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(of: Dimens.d16.responsive()),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.reviews!.items.length,
                  itemBuilder: (context, index) {
                    final review = state.reviews!.items[index];
                    return ReviewItem(review: review);
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildReviewsLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(of: Dimens.d16.responsive()),
        ...List.generate(3, (_) {
          return Container(
            margin: EdgeInsets.only(bottom: Dimens.d12.responsive()),
            padding: EdgeInsets.all(Dimens.d12.responsive()),
            height: Dimens.d100.responsive(),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
            ),
          );
        }),
      ],
    );
  }
}
