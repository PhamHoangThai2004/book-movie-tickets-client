import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/customs/images/image_custom.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/date_time_utils.dart';
import '../../../generated/assets.gen.dart';
import '../cubit/home_cubit.dart';
import 'now_playing_carousel_shimmer.dart';

class NowPlayingCarousel extends StatefulWidget {
  const NowPlayingCarousel({super.key});

  @override
  State<StatefulWidget> createState() => _NowPlayingCarouselState();
}

class _NowPlayingCarouselState extends State<NowPlayingCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.nowPlayingMovies != current.nowPlayingMovies ||
          previous.isNowPlayingLoading != current.isNowPlayingLoading,
      builder: (context, state) {
        if (state.isNowPlayingLoading) {
          return const NowPlayingCarouselShimmer();
        }

        final movies = state.nowPlayingMovies;
        if (movies.isEmpty) {
          return SizedBox.shrink();
        }

        return Column(
          children: [
            SizedBox(
              height: Dimens.d400.responsive(),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.d8.responsive()),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.d20.responsive()),
                      child: ImageCustom(
                        imageUrl: movie.poster,
                        fit: BoxFit.cover,
                        height: Dimens.d440.responsive(),
                        width: Dimens.d310.responsive(),
                      ),
                    ),
                  );
                },
              ),
            ),
            VerticalSpacing(of: Dimens.d20.responsive()),
            Text(
              movies[_currentPage].title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.style.s24.w700.whiteSmokeColor,
            ),
            VerticalSpacing(of: Dimens.d8.responsive()),
            Text(
              '${DateTimeUtils.convertDuration(movies[_currentPage].duration)} • ${movies[_currentPage].genres.take(2).map((e) => e.name).join(', ')}',
              style: AppTextStyles.style.s16.w400.silverGrayColor,
            ),
            VerticalSpacing(of: Dimens.d8.responsive()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.svgs.icStar.svg(
                  width: Dimens.d16.responsive(),
                  height: Dimens.d16.responsive(),
                  colorFilter: const ColorFilter.mode(AppColors.amberYellow, BlendMode.srcIn),
                ),
                HorizontalSpacing(of: Dimens.d4.responsive()),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${movies[_currentPage].rating} ',
                        style: AppTextStyles.style.s16.w500.whiteSmokeColor,
                      ),
                      TextSpan(
                        text: '(${movies[_currentPage].reviewCount})',
                        style: AppTextStyles.style.s12.w400.silverGrayColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            VerticalSpacing(of: Dimens.d16.responsive()),
            _buildIndicator(movies.length),
          ],
        );
      },
    );
  }

  Widget _buildIndicator(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.d4.responsive()),
          child: Container(
            width: Dimens.d24.responsive(),
            height: Dimens.d4.responsive(),
            decoration: BoxDecoration(
              color: _currentPage == index ? AppColors.amberYellow : AppColors.darkGray,
              borderRadius: BorderRadius.circular(Dimens.d2.responsive()),
            ),
          ),
        ),
      ),
    );
  }
}
