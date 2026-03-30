import 'package:client/core/customs/images/image_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/data/model/movie_model.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../core/size_config/size_config.dart';

class MovieItem extends StatelessWidget {
  final MovieModel movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
            child: ImageCustom(
              imageUrl: movie.posterUrl,
              height: Dimens.d267.responsive(),
              width: Dimens.d191.responsive(),
              fit: BoxFit.cover,
              errorWidget: Assets.svgs.icPicture.svg(
                height: Dimens.d25.responsive(),
                width: Dimens.d25.responsive(),
                colorFilter: const ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        VerticalSpacing(of: Dimens.d8.responsive()),
        Text(
          movie.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.style.s16.w700.amberYellowColor,
        ),
        VerticalSpacing(of: Dimens.d8.responsive()),
        if (movie.isNowPlaying) ...[
          _buildInfoRow(
            icon: Assets.svgs.icStar.svg(
              height: Dimens.d16.responsive(),
              width: Dimens.d16.responsive(),
              colorFilter: ColorFilter.mode(AppColors.amberYellow, BlendMode.srcIn),
            ),
            text: '${movie.rating} (${movie.voteCount})',
          ),
          VerticalSpacing(of: Dimens.d4.responsive()),
          _buildInfoRow(
            icon: Assets.svgs.icClock.svg(
              height: Dimens.d16.responsive(),
              width: Dimens.d16.responsive(),
              colorFilter: ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
            ),
            text: movie.duration ?? '',
          ),
        ] else ...[
          _buildInfoRow(
            icon: Assets.svgs.icCalendar.svg(
              height: Dimens.d16.responsive(),
              width: Dimens.d16.responsive(),
              colorFilter: ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
            ),
            text: movie.releaseDate ?? '',
          ),
        ],
        VerticalSpacing(of: Dimens.d4.responsive()),
        _buildInfoRow(
          icon: Assets.svgs.icVideoOutline.svg(
            height: Dimens.d16.responsive(),
            width: Dimens.d16.responsive(),
            colorFilter: ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
          ),
          text: movie.genres.join(', '),
        ),
      ],
    );
  }

  Widget _buildInfoRow({required Widget icon, required String text}) {
    return Row(
      children: [
        icon,
        HorizontalSpacing(of: Dimens.d6.responsive()),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.style.s12.w400.coolGrayColor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
