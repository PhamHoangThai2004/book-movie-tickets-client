import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/core/customs/toasts/shimmer_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/screens/movie/components/movie_item.dart';
import 'package:client/screens/movie/components/movie_item_shimmer.dart';
import 'package:client/screens/movie/cubit/movie_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/enums/status_enum.dart';
import '../../core/customs/toasts/toast_custom.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/size_config/size_config.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieState();
}

class _MovieState extends State<MovieScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.movieCubit.fetchMovies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<MovieCubit>().state;
    if (state.isLoadingMore) return;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 500) {
      context.movieCubit.loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: Container(
        decoration: AppThemes.mainBackground,
        child: SafeArea(
          child: BlocListener<MovieCubit, MovieState>(
            listenWhen: (previous, current) => previous.movieStatus != current.movieStatus,
            listener: (context, state) {
              if (state.movieStatus.isProcessing) {
                LoadingCustom.show();
              } else if (state.movieStatus == StatusEnum.success) {
                LoadingCustom.hideLoading();
                if (state.movie != null) {
                  context.pushNamed(NavigationService.movieDetail, extra: state.movie);
                }
              } else if (state.movieStatus == StatusEnum.failure) {
                LoadingCustom.hideLoading();
                ToastCustom.show(message: state.errorMessage);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
              child: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      VerticalSpacing(of: Dimens.d24.responsive()),
                      _buildSwitchButton(state),
                      VerticalSpacing(of: Dimens.d24.responsive()),
                      Expanded(
                        child: RefreshIndicator(
                          color: AppColors.amberYellow,
                          onRefresh: () => context.movieCubit.refreshMovies(),
                          child: _buildContent(state),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(MovieState state) {
    if (state.status == StatusEnum.processing && state.currentMovies.isEmpty) {
      return _buildLoadingShimmer();
    }

    if (state.status == StatusEnum.failure && state.currentMovies.isEmpty) {
      return Center(child: Text(state.errorMessage, style: AppTextStyles.style.s16.whiteColor));
    }

    if (state.currentMovies.isEmpty) {
      return Center(child: Text('no_movies_found'.tr(), style: AppTextStyles.style.s16.whiteColor));
    }

    return GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimens.d16.responsive(),
        crossAxisSpacing: Dimens.d16.responsive(),
        childAspectRatio: 0.5,
      ),
      itemCount: state.currentMovies.length,
      itemBuilder: (context, index) {
        return MovieItem(movie: state.currentMovies[index], isNowPlaying: state.isNowPlaying);
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return ShimmerCustom(
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: Dimens.d16.responsive(),
          crossAxisSpacing: Dimens.d16.responsive(),
          childAspectRatio: 0.5,
        ),
        itemCount: 6,
        itemBuilder: (_, _) => const MovieItemShimmer(),
      ),
    );
  }

  Widget _buildSwitchButton(MovieState state) {
    return Container(
      padding: EdgeInsets.all(Dimens.d4.responsive()),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
      ),
      child: Row(
        children: [
          _buildTabItem(
            title: 'now_playing'.tr(),
            isActive: state.isNowPlaying,
            onTap: () {
              context.movieCubit.onTabChanged(true);
            },
          ),
          _buildTabItem(
            title: 'coming_soon'.tr(),
            isActive: !state.isNowPlaying,
            onTap: () {
              context.movieCubit.onTabChanged(false);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: CupertinoButtonCustom(
        onPressed: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
          decoration: BoxDecoration(
            color: isActive ? AppColors.amberYellow : AppColors.transparent,
            borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTextStyles.style.s18.w700.copyWith(
              color: isActive ? AppColors.black : AppColors.silverGray,
            ),
          ),
        ),
      ),
    );
  }
}
