import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/core/utils/app_utils.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/movie_detail_cubit.dart';

class ReviewInput extends StatefulWidget {
  final String movieId;

  const ReviewInput({super.key, required this.movieId});

  @override
  State<ReviewInput> createState() => _ReviewInputState();
}

class _ReviewInputState extends State<ReviewInput> {
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (!AppUtils.isLoggedIn()) {
      AppUtils.requestLogin(context: context);
      return;
    }

    context.movieDetailCubit.addReview(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieDetailCubit, MovieDetailState>(
      listenWhen: (previous, current) => current.submitReviewStatus != previous.submitReviewStatus,
      listener: (context, state) {
        if (state.submitReviewStatus.isProcessing) {
          LoadingCustom.show();
        } else if (state.submitReviewStatus.isSuccess) {
          LoadingCustom.hideLoading();
          _commentController.clear();
        }
        if (state.submitReviewStatus.isFailure) {
          LoadingCustom.hideLoading();
          ToastCustom.show(message: state.errorMessage);
        }
      },
      child: Container(
        padding: EdgeInsets.all(Dimens.d16.responsive()),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1D1D),
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('write_review'.tr(), style: AppTextStyles.style.s20.w700.whiteColor),
                BlocBuilder<MovieDetailCubit, MovieDetailState>(
                  buildWhen: (previous, current) => current.isValid != previous.isValid,
                  builder: (context, state) {
                    return ButtonCustom(
                      width: Dimens.d150.responsive(),
                      titleStyle: AppTextStyles.style.s14.w400.copyWith(
                        color: state.isValid ? AppColors.black : AppColors.white,
                      ),
                      title: 'submit_review'.tr(),
                      buttonStyle: state.isValid
                          ? AppThemes.yellowButtonStyle
                          : AppThemes.disabledButtonStyle,
                      onPressed: state.isValid ? _submitReview : null,
                    );
                  },
                ),
              ],
            ),
            VerticalSpacing(of: Dimens.d16.responsive()),

            BlocBuilder<MovieDetailCubit, MovieDetailState>(
              buildWhen: (previous, current) => current.rating != previous.rating,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(of: Dimens.d8.responsive()),
                    Row(
                      children: List.generate(10, (index) {
                        final starNumber = index + 1;
                        final isSelected = starNumber <= state.rating;
                        return CupertinoButtonCustom(
                          onPressed: () => context.movieDetailCubit.setRating(starNumber),
                          child: Padding(
                            padding: EdgeInsets.only(right: Dimens.d6.responsive()),
                            child: Assets.svgs.icStar.svg(
                              colorFilter: ColorFilter.mode(
                                isSelected ? AppColors.amberYellow : AppColors.darkGray,
                                BlendMode.srcIn,
                              ),
                              width: Dimens.d24.responsive(),
                              height: Dimens.d24.responsive(),
                            ),
                          ),
                        );
                      }),
                    ),
                    VerticalSpacing(of: Dimens.d4.responsive()),
                    Text('${state.rating}/10', style: AppTextStyles.style.s12.w400.coolGrayColor),
                  ],
                );
              },
            ),

            VerticalSpacing(of: Dimens.d16.responsive()),

            TextFormField(
              controller: _commentController,
              style: AppTextStyles.style.s14.w400.whiteColor,
              onChanged: (value) => context.movieDetailCubit.setComment(value),
              maxLines: 4,
              minLines: 4,
              cursorColor: AppColors.amberYellow,
              decoration: InputDecoration(
                hintText: 'write_your_comment'.tr(),
                hintStyle: AppTextStyles.style.s14.w400.coolGrayColor,
                filled: true,
                fillColor: AppColors.obsidian,
                contentPadding: EdgeInsets.all(Dimens.d12.responsive()),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                  borderSide: BorderSide(color: AppColors.darkCharcoal),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                  borderSide: BorderSide(color: AppColors.darkCharcoal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                  borderSide: BorderSide(color: AppColors.amberYellow),
                ),
              ),
            ),
            VerticalSpacing(of: Dimens.d16.responsive()),
          ],
        ),
      ),
    );
  }
}
