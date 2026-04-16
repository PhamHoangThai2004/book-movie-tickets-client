import 'package:client/core/customs/images/image_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/data/enums/age_rating_enum.dart';
import 'package:client/data/model/ticket_model.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/size_config.dart';

class MovieInfoLayout extends StatelessWidget {
  final MovieInfo movie;

  const MovieInfoLayout({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
          child: ImageCustom(
            imageUrl: movie.poster,
            width: Dimens.d125.responsive(),
            height: Dimens.d177.responsive(),
            fit: BoxFit.cover,
          ),
        ),
        HorizontalSpacing(of: Dimens.d16.responsive()),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: AppTextStyles.style.s20.w600.blackColor,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              VerticalSpacing(of: Dimens.d12.responsive()),
              _buildInfoRow(
                Assets.svgs.icClock,
                DateTimeUtils.convertDuration(movie.duration),
              ),
              VerticalSpacing(of: Dimens.d8.responsive()),
              _buildInfoRow(Assets.svgs.icCalendar, movie.ageRating.displayName),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(SvgGenImage icon, String text) {
    return Row(
      children: [
        icon.svg(
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          width: Dimens.d20.responsive(),
          height: Dimens.d20.responsive(),
        ),
        HorizontalSpacing(of: Dimens.d8.responsive()),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.style.s14.w400.blackColor,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
