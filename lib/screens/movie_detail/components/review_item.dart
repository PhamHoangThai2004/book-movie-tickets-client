import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_colors.dart';
import '../../../data/model/review_model.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimens.d12.responsive()),
      padding: EdgeInsets.all(Dimens.d12.responsive()),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1D),
        borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: Dimens.d20.responsive(),
                      backgroundColor: AppColors.darkGray,
                      backgroundImage: review.user.avatar != null && review.user.avatar!.isNotEmpty
                          ? NetworkImage(review.user.avatar!)
                          : null,
                      child: review.user.avatar == null || review.user.avatar!.isEmpty
                          ? Text(
                              review.user.name.isNotEmpty ? review.user.name[0].toUpperCase() : '?',
                              style: AppTextStyles.style.s16.w700.whiteColor,
                            )
                          : null,
                    ),
                    HorizontalSpacing(of: Dimens.d10.responsive()),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.user.name,
                            style: AppTextStyles.style.s14.w600.whiteColor,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          VerticalSpacing(of: Dimens.d2.responsive()),
                          Text(
                            _formatDate(review.createdAt),
                            style: AppTextStyles.style.s12.w400.coolGrayColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildStarRating(review.rating),
            ],
          ),
          VerticalSpacing(of: Dimens.d10.responsive()),
          Text(
            review.comment,
            style: AppTextStyles.style.s14.w400.whiteColor,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(5, (index) {
        final isFilled = index < rating;
        return Padding(
          padding: EdgeInsets.only(left: Dimens.d2.responsive()),
          child: Assets.svgs.icStar.svg(
            colorFilter: ColorFilter.mode(
              isFilled ? AppColors.amberYellow : AppColors.coolGray,
              BlendMode.srcIn,
            ),
            width: Dimens.d16.responsive(),
            height: Dimens.d16.responsive(),
          ),
        );
      }),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'today'.tr();
      } else if (difference.inDays == 1) {
        return 'yesterday'.tr();
      } else if (difference.inDays < 7) {
        return '${difference.inDays} ${'days_ago'.tr()}';
      } else {
        return DateTimeUtils.fromIso8601(dateString);
      }
    } catch (e) {
      return dateString;
    }
  }
}
