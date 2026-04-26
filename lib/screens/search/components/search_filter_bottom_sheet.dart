import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/customs/buttons/button_custom.dart';
import '../../../data/enums/movie_status_enum.dart';
import '../../../data/model/genre_model.dart';
import '../../../generated/assets.gen.dart';
import '../cubit/search_cubit.dart';

Future<void> showFilterBottomSheet({required BuildContext context}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.black.withValues(alpha: 0.6),
    builder: (_) {
      return BlocProvider.value(value: context.searchCubit, child: const _SearchFilterSheet());
    },
  );
}

class _SearchFilterSheet extends StatefulWidget {
  const _SearchFilterSheet();

  @override
  State<_SearchFilterSheet> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<_SearchFilterSheet> {
  MovieStatusEnum? _selectedStatus;
  GenreModel? _selectedGenre;

  @override
  void initState() {
    super.initState();
    final state = context.read<SearchCubit>().state;
    _selectedStatus = state.selectedStatus;
    _selectedGenre = state.selectedGenre;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.graphite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.d24.responsive()),
              topRight: Radius.circular(Dimens.d24.responsive()),
            ),
          ),
          padding: EdgeInsets.only(
            top: Dimens.d12.responsive(),
            left: Dimens.d20.responsive(),
            right: Dimens.d20.responsive(),
            bottom: MediaQuery.of(context).padding.bottom + Dimens.d24.responsive(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: Dimens.d40.responsive(),
                  height: Dimens.d4.responsive(),
                  decoration: BoxDecoration(
                    color: AppColors.carbonGray,
                    borderRadius: BorderRadius.circular(Dimens.d2.responsive()),
                  ),
                ),
              ),
              VerticalSpacing(of: Dimens.d24.responsive()),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('filter'.tr(), style: AppTextStyles.style.s20.w700.whiteColor),
                  CupertinoButtonCustom(
                    onPressed: context.pop,
                    child: Container(
                      padding: EdgeInsets.all(Dimens.d8.responsive()),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white.withValues(alpha: 0.1),
                      ),
                      child: Assets.svgs.icClose.svg(),
                    ),
                  ),
                ],
              ),
              VerticalSpacing(of: Dimens.d24.responsive()),

              _buildSectionTitle('status'.tr()),
              VerticalSpacing(of: Dimens.d12.responsive()),
              Wrap(
                spacing: Dimens.d12.responsive(),
                runSpacing: Dimens.d12.responsive(),
                children: [
                  _buildFilterChip(
                    label: 'all'.tr(),
                    isSelected: _selectedStatus == null,
                    onTap: () => setState(() => _selectedStatus = null),
                  ),
                  _buildFilterChip(
                    label: MovieStatusEnum.nowShowing.title,
                    isSelected: (_selectedStatus ?? MovieStatusEnum.ended).isNowShowing,
                    onTap: () => setState(() => _selectedStatus = MovieStatusEnum.nowShowing),
                  ),
                  _buildFilterChip(
                    label: MovieStatusEnum.comingSoon.title,
                    isSelected: (_selectedStatus ?? MovieStatusEnum.ended).isComingSoon,
                    onTap: () => setState(() => _selectedStatus = MovieStatusEnum.comingSoon),
                  ),
                ],
              ),
              VerticalSpacing(of: Dimens.d24.responsive()),

              _buildSectionTitle('genre'.tr()),
              VerticalSpacing(of: Dimens.d12.responsive()),
              state.genres.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: Dimens.d20.responsive()),
                        child: const CircularProgressIndicator(color: AppColors.amberYellow),
                      ),
                    )
                  : Wrap(
                      spacing: Dimens.d12.responsive(),
                      runSpacing: Dimens.d12.responsive(),
                      children: [
                        _buildFilterChip(
                          label: 'all'.tr(),
                          isSelected: _selectedGenre == null,
                          onTap: () => setState(() => _selectedGenre = null),
                        ),
                        ...state.genres.map(
                          (genre) => _buildFilterChip(
                            label: genre.name,
                            isSelected: _selectedGenre == genre,
                            onTap: () => setState(() => _selectedGenre = genre),
                          ),
                        ),
                      ],
                    ),
              VerticalSpacing(of: Dimens.d32.responsive()),

              Row(
                spacing: Dimens.d8.responsive(),
                children: [
                  Expanded(
                    child: ButtonCustom(
                      onPressed: () {
                        setState(() {
                          _selectedStatus = null;
                          _selectedGenre = null;
                        });
                      },
                      titleStyle: AppTextStyles.style.s16.w500.whiteColor,
                      buttonStyle: BoxDecoration(
                        color: AppColors.transparent,
                        borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
                        border: Border.all(color: AppColors.amberYellow, width: 1),
                      ),
                      title: 'reset'.tr(),
                    ),
                  ),
                  Expanded(
                    child: ButtonCustom(
                      onPressed: () {
                        context.searchCubit.setFilter(_selectedStatus, _selectedGenre);
                        Navigator.pop(context);
                      },
                      titleStyle: AppTextStyles.style.s16.w500.blackColor,
                      buttonStyle: BoxDecoration(
                        color: AppColors.amberYellow,
                        borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
                      ),
                      title: 'apply'.tr(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.style.s16.w600.whiteSmokeColor);
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.d20.responsive(),
          vertical: Dimens.d10.responsive(),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.amberYellow : AppColors.obsidian,
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
          border: Border.all(
            color: isSelected ? AppColors.amberYellow : AppColors.carbonGray,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.style.s14.w500.copyWith(
            color: isSelected ? AppColors.black : AppColors.white,
          ),
        ),
      ),
    );
  }
}
