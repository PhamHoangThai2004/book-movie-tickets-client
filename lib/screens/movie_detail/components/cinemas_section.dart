import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_colors.dart';
import '../../../data/enums/status_enum.dart';
import '../../../data/model/cinema_model.dart';
import '../cubit/movie_detail_cubit.dart';

class CinemasSection extends StatelessWidget {
  const CinemasSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      buildWhen: (previous, current) =>
          previous.cinemasStatus != current.cinemasStatus || previous.cinemas != current.cinemas,
      builder: (context, state) {
        if (state.cinemasStatus == StatusEnum.processing) {
          return _buildCinemaLoading();
        }

        if (state.cinemas.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('cinema'.tr(), style: AppTextStyles.style.s24.w700.whiteColor),
            BlocBuilder<MovieDetailCubit, MovieDetailState>(
              buildWhen: (previous, current) =>
                  previous.selectedCinemaId != current.selectedCinemaId,
              builder: (context, state) {
                final selectedCinemaId = state.selectedCinemaId ?? state.cinemas.first.id;

                return ListView.separated(
                  primary: false,
                  itemCount: state.cinemas.length,
                  padding: EdgeInsets.only(top: Dimens.d14.responsive()),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, _) => VerticalSpacing(of: Dimens.d12.responsive()),
                  itemBuilder: (_, index) {
                    final cinema = state.cinemas[index];
                    return _buildCinemaCard(
                      cinema,
                      isSelected: cinema.id == selectedCinemaId,
                      onPressed: () => context.movieDetailCubit.selectCinema(cinema.id),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCinemaLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('cinema'.tr(), style: AppTextStyles.style.s24.w700.whiteColor),
        VerticalSpacing(of: Dimens.d12.responsive()),
        ...List.generate(2, (_) {
          return Container(
            margin: EdgeInsets.only(bottom: Dimens.d12.responsive()),
            height: Dimens.d74.responsive(),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCinemaCard(
    CinemaModel cinema, {
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return CupertinoButtonCustom(
      onPressed: () {
        if (!isSelected) onPressed();
      },
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(Dimens.d20.responsive()),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.amberYellow.withValues(alpha: 0.1) : AppColors.obsidian,
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
          border: Border.all(
            color: isSelected ? AppColors.amberYellow : AppColors.transparent,
            width: Dimens.d1.responsive(),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cinema.name, style: AppTextStyles.style.s20.w700.whiteSmokeColor),
            VerticalSpacing(of: Dimens.d6.responsive()),
            Text(
              cinema.address,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.style.s12.w400.whiteSmokeColor,
            ),
          ],
        ),
      ),
    );
  }
}
