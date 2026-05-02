import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/navigation/navigation_service.dart';
import 'package:client/screens/home/components/coming_soon_carousel_shimmer.dart';
import 'package:client/screens/home/components/home_header_layout.dart';
import 'package:client/screens/home/components/now_playing_carousel.dart';
import 'package:client/screens/home/components/previews_movies_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/common/register_cubit.dart';
import '../../core/customs/toasts/loading_custom.dart';
import '../../core/customs/toasts/toast_custom.dart';
import '../../core/size_config/app_dimen.dart';
import '../../core/size_config/dimens.dart';
import '../../core/size_config/size_config.dart';
import '../../core/styles/app_text_styles.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_themes.dart';
import '../../data/enums/movie_status_enum.dart';
import '../../data/enums/status_enum.dart';
import '../../generated/assets.gen.dart';
import 'components/coming_soon_movie_item.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.homeCubit.getMovies(MovieStatusEnum.nowShowing);
    context.homeCubit.getMovies(MovieStatusEnum.comingSoon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: Container(
        decoration: AppThemes.mainBackground,
        child: SafeArea(
          child: BlocListener<HomeCubit, HomeState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status.isProcessing) {
                LoadingCustom.show();
              } else if (state.status.isSuccess) {
                LoadingCustom.hideLoading();
                if (state.movie != null) {
                  context.pushNamed(NavigationService.movieDetail, extra: state.movie);
                }
              } else if (state.status.isFailure) {
                LoadingCustom.hideLoading();
                ToastCustom.show(message: state.errorMessage);
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpacing(of: Dimens.d20),
                      HomeHeaderLayout(),
                      VerticalSpacing(of: Dimens.d24.responsive()),
                      _buildSearchBar(),
                    ],
                  ),
                ),
                VerticalSpacing(of: Dimens.d24.responsive()),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(title: 'now_playing'.tr(), onTapSeeAll: () {}),
                        VerticalSpacing(of: Dimens.d16.responsive()),
                        NowPlayingCarousel(),
                        VerticalSpacing(of: Dimens.d24.responsive()),

                        BlocBuilder<HomeCubit, HomeState>(
                          buildWhen: (previous, current) =>
                              previous.comingSoonMovies != current.comingSoonMovies,
                          builder: (context, state) {
                            if (state.comingSoonMovies.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return _buildSectionHeader(
                              title: 'coming_soon'.tr(),
                              onTapSeeAll: () {},
                            );
                          },
                        ),
                        VerticalSpacing(of: Dimens.d16.responsive()),
                        _buildComingSoonSection(),
                        VerticalSpacing(of: Dimens.d24.responsive()),
                        Text(
                          'promo_and_discount'.tr(),
                          style: AppTextStyles.style.s24.w700.whiteSmokeColor,
                        ),
                        VerticalSpacing(of: Dimens.d16.responsive()),
                        Assets.images.imgPromotion.image(),
                        VerticalSpacing(of: Dimens.d24.responsive()),
                        _buildSectionHeader(title: 'new_movie'.tr(), onTapSeeAll: () {}),
                        VerticalSpacing(of: Dimens.d16.responsive()),
                        PreviewsMoviesList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return CupertinoButtonCustom(
      onPressed: () => context.pushNamed(NavigationService.search),
      child: Container(
        height: Dimens.d48.responsive(),
        padding: EdgeInsets.all(Dimens.d16.responsive()),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
        ),
        child: Row(
          spacing: Dimens.d8.responsive(),
          children: [
            Assets.svgs.icSearch.svg(
              width: Dimens.d24.responsive(),
              height: Dimens.d24.responsive(),
              colorFilter: const ColorFilter.mode(AppColors.whiteSmoke, BlendMode.srcIn),
            ),
            Text('search'.tr(), style: AppTextStyles.style.s14.w400.coolGrayColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required VoidCallback onTapSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.style.s24.w700.whiteSmokeColor),
        CupertinoButtonCustom(
          onPressed: onTapSeeAll,
          child: Row(
            children: [
              Text('see_all'.tr(), style: AppTextStyles.style.s14.w400.amberYellowColor),
              HorizontalSpacing(of: Dimens.d4.responsive()),
              Assets.svgs.icArrowRight.svg(
                width: Dimens.d16.responsive(),
                height: Dimens.d16.responsive(),
                colorFilter: const ColorFilter.mode(AppColors.amberYellow, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComingSoonSection() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.comingSoonMovies != current.comingSoonMovies ||
          previous.isComingSoonLoading != current.isComingSoonLoading,
      builder: (context, state) {
        if (state.isComingSoonLoading) {
          return const ComingSoonCarouselShimmer();
        }

        final movies = state.comingSoonMovies;
        if (movies.isEmpty) {
          return SizedBox.shrink();
        }

        return SizedBox(
          height: Dimens.d360.responsive(),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: Dimens.d16.responsive()),
                child: SizedBox(
                  width: Dimens.d191.responsive(),
                  child: ComingSoonMovieItem(movie: movies[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
