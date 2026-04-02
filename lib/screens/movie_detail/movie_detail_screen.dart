import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/customs/images/image_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/data/enums/age_rating_enum.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/size_config/size_config.dart';
import '../../data/model/movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<StatefulWidget> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetailScreen> {
  bool _isStoryExpanded = false;

  MovieModel get _movie => widget.movie;

  List<String> _splitPeople(String source) {
    return source.split(',').map((item) => item.trim()).where((item) => item.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    final directors = _splitPeople(_movie.director);
    final casts = _splitPeople(_movie.cast);
    final genres = _movie.genres.map((item) => item.name).join(', ');
    return Scaffold(
      backgroundColor: AppColors.black,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: AppThemes.mainBackground,
        child: SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildTopBanner()),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalSpacing(of: Dimens.d16.responsive()),
                      _buildInfoRow(label: '${'genre'.tr()}:', value: genres),
                      _buildInfoRow(label: '${'censorship'.tr()}:', value: _movie.ageRating.displayName),
                      _buildInfoRow(label: '${'language'.tr()}:', value: _movie.languages),
                      VerticalSpacing(of: Dimens.d8.responsive()),
                      Text('storyline'.tr(), style: AppTextStyles.style.s32.w700.whiteColor),
                      VerticalSpacing(of: Dimens.d12.responsive()),
                      Text(
                        _movie.description,
                        style: AppTextStyles.style.s16.w900.whiteColor,
                        maxLines: _isStoryExpanded ? null : 4,
                        overflow: _isStoryExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      ),
                      VerticalSpacing(of: Dimens.d4.responsive()),
                      GestureDetector(
                        onTap: () => setState(() => _isStoryExpanded = !_isStoryExpanded),
                        child: Text(
                          _isStoryExpanded ? 'see_less'.tr() : 'see_more'.tr(),
                          style: AppTextStyles.style.s16.w700.amberYellowColor,
                        ),
                      ),
                      VerticalSpacing(of: Dimens.d20.responsive()),
                      _buildPeopleSection(title: 'director'.tr(), items: directors),
                      VerticalSpacing(of: Dimens.d20.responsive()),
                      _buildPeopleSection(title: 'actor'.tr(), items: casts),
                      VerticalSpacing(of: Dimens.d24.responsive()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBanner() {
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
                  imageUrl: _movie.poster,
                  fit: BoxFit.cover,
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
                      colors: [Color(0x22000000), Color(0xCC000000)],
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
            _movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.style.s24.w700.whiteSmokeColor,
          ),
          VerticalSpacing(of: Dimens.d4.responsive()),
          Text(
            '${DateTimeUtils.convertDuration(_movie.duration)} · ${DateTimeUtils.fromIso8601(_movie.releaseDate)}',
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
                                text: _movie.rating.toString(),
                                style: AppTextStyles.style.s16.w700.whiteSmokeColor,
                              ),
                              TextSpan(
                                text: ' (${_movie.reviewCount})',
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
                        final isFilled = index < _movie.rating;
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
                onPressed: () {
                  if (_movie.trailer == null) {
                    ToastCustom.show(message: 'movie_not_trailer'.tr());
                  }
                },
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

  Widget _buildInfoRow({required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.d10.responsive()),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimens.d120.responsive(),
            child: Text(label, style: AppTextStyles.style.s16.w400.coolGrayColor),
          ),
          Expanded(child: Text(value, style: AppTextStyles.style.s18.w600.whiteColor)),
        ],
      ),
    );
  }

  Widget _buildPeopleSection({required String title, required List<String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.style.s32.w700.whiteColor),
        VerticalSpacing(of: Dimens.d12.responsive()),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(items.length, (index) {
              final name = items[index];
              return Padding(
                padding: EdgeInsets.only(right: Dimens.d10.responsive()),
                child: Container(
                  constraints: BoxConstraints(minWidth: Dimens.d100.responsive()),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.d10.responsive(),
                    vertical: Dimens.d8.responsive(),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1D1D),
                    borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: Dimens.d14.responsive(),
                        backgroundColor: AppColors.darkGray,
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : '?',
                          style: AppTextStyles.style.s12.w700.whiteColor,
                        ),
                      ),
                      HorizontalSpacing(of: Dimens.d8.responsive()),
                      Text(name, style: AppTextStyles.style.s14.w500.whiteColor),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
