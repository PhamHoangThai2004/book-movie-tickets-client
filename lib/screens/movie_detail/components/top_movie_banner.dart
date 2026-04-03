import 'package:client/data/model/movie_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/customs/buttons/cupertino_button_custom.dart';
import '../../../core/customs/images/image_custom.dart';
import '../../../core/customs/toasts/toast_custom.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/date_time_utils.dart';
import '../../../generated/assets.gen.dart';

class TopMovieBanner extends StatefulWidget {
  final MovieModel movie;

  @override
  State<StatefulWidget> createState() => TopMovieBannerState();

  const TopMovieBanner({super.key, required this.movie});
}

class TopMovieBannerState extends State<TopMovieBanner> {
  @override
  Widget build(BuildContext context) {
    final statusBarTop = MediaQuery.paddingOf(context).top;
    return SizedBox(
      height: Dimens.d380.responsive() + statusBarTop,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Dimens.d24.responsive()),
              bottomRight: Radius.circular(Dimens.d24.responsive()),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ImageCustom(
                  imageUrl: widget.movie.poster,
                  fit: BoxFit.fitWidth,
                  errorWidget: Assets.svgs.icPicture.svg(
                    height: Dimens.d28.responsive(),
                    width: Dimens.d28.responsive(),
                    colorFilter: const ColorFilter.mode(AppColors.silver, BlendMode.srcIn),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x00000000), Color(0x66000000)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: Dimens.d16.responsive(),
            top: statusBarTop + Dimens.d16.responsive(),
            child: CupertinoButtonCustom(
              onPressed: context.pop,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                ),
                alignment: Alignment.center,
                child: Assets.svgs.icArrowLeft.svg(
                  width: Dimens.d48.responsive(),
                  height: Dimens.d48.responsive(),
                  colorFilter: const ColorFilter.mode(AppColors.whiteSmoke, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          Positioned(
            left: Dimens.d16.responsive(),
            right: Dimens.d16.responsive(),
            bottom: Dimens.d8.responsive(),
            child: _buildInfoCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(Dimens.d20.responsive()),
      decoration: BoxDecoration(
        color: AppColors.obsidian,
        borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.style.s24.w700.whiteSmokeColor,
          ),
          VerticalSpacing(of: Dimens.d4.responsive()),
          Text(
            '${DateTimeUtils.convertDuration(widget.movie.duration)} · ${DateTimeUtils.fromIso8601(widget.movie.releaseDate)}',
            style: AppTextStyles.style.s16.w400.silverGrayColor,
          ),
          VerticalSpacing(of: Dimens.d12.responsive()),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('review'.tr(), style: AppTextStyles.style.s16.w700.whiteSmokeColor),
                        HorizontalSpacing(of: Dimens.d6.responsive()),
                        Assets.svgs.icStar.svg(
                          width: Dimens.d16.responsive(),
                          height: Dimens.d16.responsive(),
                          colorFilter: const ColorFilter.mode(
                            AppColors.amberYellow,
                            BlendMode.srcIn,
                          ),
                        ),
                        HorizontalSpacing(of: Dimens.d4.responsive()),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.movie.rating.toString(),
                                style: AppTextStyles.style.s16.w700.whiteSmokeColor,
                              ),
                              TextSpan(
                                text: ' (${widget.movie.reviewCount})',
                                style: AppTextStyles.style.s14.w400.silverGrayColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    VerticalSpacing(of: Dimens.d8.responsive()),
                    Row(
                      children: List.generate(5, (index) {
                        final isFilled = index < widget.movie.rating;
                        return Padding(
                          padding: EdgeInsets.only(right: Dimens.d6.responsive()),
                          child: Assets.svgs.icStar.svg(
                            width: Dimens.d22.responsive(),
                            height: Dimens.d22.responsive(),
                            colorFilter: ColorFilter.mode(
                              isFilled ? AppColors.amberYellow : AppColors.slateGray,
                              BlendMode.srcIn,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              CupertinoButtonCustom(
                onPressed: _handleWatchTrailer,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.d12.responsive(),
                    vertical: Dimens.d8.responsive(),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.silverGray),
                    borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
                  ),
                  child: Row(
                    children: [
                      Assets.svgs.icPlay.svg(),
                      HorizontalSpacing(of: Dimens.d8.responsive()),
                      Text(
                        'watch_trailer'.tr(),
                        style: AppTextStyles.style.s12.w700.silverGrayColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleWatchTrailer() {
    final trailerUrl = widget.movie.trailer;
    if (trailerUrl == null || trailerUrl.trim().isEmpty) {
      ToastCustom.show(message: 'movie_not_trailer'.tr());
      return;
    }
    context.movieDetailCubit.setIsPlaying(true);
  }
}
