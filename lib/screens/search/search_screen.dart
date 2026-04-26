import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/screens/search/components/search_header_layout.dart';
import 'package:client/screens/search/components/search_results_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/customs/app_bars/header_custom.dart';
import '../../data/enums/status_enum.dart';
import '../../generated/assets.gen.dart';
import '../movie/components/movie_item.dart';
import 'cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.searchCubit.getGenres();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.searchCubit.loadMoreResults();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.warmBlack,
      body: Container(
        decoration: AppThemes.mainBackground,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(of: SizeConfig.appDefaultPadding),
                    HeaderCustom(title: 'search'.tr(),),
                    VerticalSpacing(of: Dimens.d20.responsive()),
                    SearchHeaderLayout(),
                  ],
                ),
              ),
              VerticalSpacing(of: Dimens.d24.responsive()),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.searchQuery != current.searchQuery,
                  builder: (context, state) {
                    if (state.searchQuery.isEmpty || state.searchResult == null) {
                      return _buildEmptyState();
                    }

                    if (state.status.isProcessing && state.searchResult!.items.isEmpty) {
                      return const SearchResultsShimmer();
                    }

                    if (state.status == StatusEnum.failure) {
                      return _buildErrorState(state.errorMessage);
                    }

                    if (state.searchResult!.items.isEmpty && state.status.isSuccess) {
                      return _buildNoResultsState();
                    }

                    return _buildResultsGrid(state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svgs.icSearch.svg(
            width: Dimens.d80.responsive(),
            height: Dimens.d80.responsive(),
            colorFilter: const ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
          ),
          VerticalSpacing(of: Dimens.d16.responsive()),
          Text('search_for_movies'.tr(), style: AppTextStyles.style.s16.w600.whiteSmokeColor),
          VerticalSpacing(of: Dimens.d8.responsive()),
          Text('start_typing_movie_name'.tr(), style: AppTextStyles.style.s14.w400.coolGrayColor),
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svgs.icSearch.svg(
            width: Dimens.d80.responsive(),
            height: Dimens.d80.responsive(),
            colorFilter: const ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
          ),
          VerticalSpacing(of: Dimens.d16.responsive()),
          Text('no_results_found'.tr(), style: AppTextStyles.style.s16.w600.whiteSmokeColor),
          VerticalSpacing(of: Dimens.d8.responsive()),
          Text('try_different_keyword'.tr(), style: AppTextStyles.style.s14.w400.coolGrayColor),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svgs.icExclamationCircle.svg(
            width: Dimens.d80.responsive(),
            height: Dimens.d80.responsive(),
            colorFilter: const ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
          ),
          VerticalSpacing(of: Dimens.d16.responsive()),
          Text('error_occurred'.tr(), style: AppTextStyles.style.s16.w600.whiteSmokeColor),
          VerticalSpacing(of: Dimens.d8.responsive()),
          Text(
            errorMessage,
            style: AppTextStyles.style.s14.w400.coolGrayColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResultsGrid(SearchState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: Dimens.d16.responsive()),
            child: Text(
              '${'found'.tr()} ${state.searchResult!.items.length} ${'results'.tr()}',
              style: AppTextStyles.style.s14.w400.amberYellowColor,
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Dimens.d16.responsive(),
                mainAxisSpacing: Dimens.d20.responsive(),
                childAspectRatio: 0.6,
              ),
              itemCount: state.searchResult!.items.length + (state.isLoadingMore ? 2 : 0),
              itemBuilder: (context, index) {
                if (index >= state.searchResult!.items.length) {
                  return _buildLoadingItem();
                }
                return MovieItem(movie: state.searchResult!.items[index], isNowPlaying: true);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingItem() {
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
          ),
        ),
      ],
    );
  }
}
