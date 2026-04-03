import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/data/enums/age_rating_enum.dart';
import 'package:client/screens/movie_detail/components/top_movie_banner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/size_config/size_config.dart';
import '../../data/model/movie_model.dart';
import 'components/cinemas_section.dart';
import 'components/trailer_layout.dart';
import 'cubit/movie_detail_cubit.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<StatefulWidget> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetailScreen> {
  bool _isStoryExpanded = false;

  MovieModel get _movie => widget.movie;

  @override
  void initState() {
    super.initState();
    context.movieDetailCubit.getCinemas(_movie.id);
  }

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
      body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          return Container(
            decoration: AppThemes.mainBackground,
            child: SafeArea(
              top: false,
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: TopMovieBanner(movie: _movie),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VerticalSpacing(of: Dimens.d16.responsive()),
                              _buildInfoRow(label: '${'genre'.tr()}:', value: genres),
                              _buildInfoRow(
                                label: '${'censorship'.tr()}:',
                                value: _movie.ageRating.displayName,
                              ),
                              _buildInfoRow(label: '${'language'.tr()}:', value: _movie.languages),
                              VerticalSpacing(of: Dimens.d8.responsive()),
                              Text('storyline'.tr(), style: AppTextStyles.style.s24.w700.whiteColor),
                              VerticalSpacing(of: Dimens.d12.responsive()),
                              Text(
                                _movie.description,
                                style: AppTextStyles.style.s16.w700.whiteColor,
                                maxLines: _isStoryExpanded ? null : 4,
                                overflow: _isStoryExpanded
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                              ),
                              VerticalSpacing(of: Dimens.d4.responsive()),
                              CupertinoButtonCustom(
                                onPressed: () => setState(() => _isStoryExpanded = !_isStoryExpanded),
                                child: Text(
                                  _isStoryExpanded ? 'see_less'.tr() : 'see_more'.tr(),
                                  style: AppTextStyles.style.s16.w700.amberYellowColor,
                                ),
                              ),
                              VerticalSpacing(of: Dimens.d20.responsive()),
                              _buildPeopleSection(title: 'director'.tr(), items: directors),
                              VerticalSpacing(of: Dimens.d20.responsive()),
                              _buildPeopleSection(title: 'actor'.tr(), items: casts),
                              VerticalSpacing(of: Dimens.d20.responsive()),
                              CinemasSection(),
                              VerticalSpacing(of: Dimens.d100.responsive()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(alignment: Alignment.bottomCenter, child: _buildBottomAction()),
                  if (state.isPlaying)
                    Positioned.fill(
                      child: Container(
                          color: Colors.black.withValues(alpha: 0.7),
                          child: Center(
                            child: TrailerLayout(
                              trailerUrl: _movie.trailer ?? '',
                              onClose: () => context.movieDetailCubit.setIsPlaying(false),
                            ),
                          ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomAction() {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(color: AppColors.transparent),
        padding: EdgeInsets.fromLTRB(
          SizeConfig.appDefaultPadding,
          Dimens.d10.responsive(),
          SizeConfig.appDefaultPadding,
          Dimens.d12.responsive(),
        ),
        child: ButtonCustom(title: 'book_tickets'.tr(), onPressed: () {}),
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
        Text(title, style: AppTextStyles.style.s24.w700.whiteColor),
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
                          style: AppTextStyles.style.s15.w700.whiteColor,
                        ),
                      ),
                      HorizontalSpacing(of: Dimens.d8.responsive()),
                      Text(name, style: AppTextStyles.style.s14.w400.whiteColor),
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
