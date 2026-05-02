import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
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
  int _selectedRating = 0;

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

    if (_selectedRating == 0) {
      ToastCustom.show(message: 'pls_select_rating'.tr());
      return;
    }

    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      ToastCustom.show(message: 'pls_enter_comment'.tr());
      return;
    }

    context.movieDetailCubit.addReview(
      movieId: widget.movieId,
      rating: _selectedRating,
      comment: comment,
    );

    _commentController.clear();
    _selectedRating = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                buildWhen: (p, c) => p.submitReviewStatus != c.submitReviewStatus,
                builder: (context, state) {
                  return ButtonCustom(
                    width: Dimens.d150.responsive(),
                    titleStyle: AppTextStyles.style.s14.w400.blackColor,
                    title: 'submit_review'.tr(),
                    onPressed: state.submitReviewStatus.isProcessing ? null : _submitReview,
                  );
                },
              ),
            ],
          ),
          VerticalSpacing(of: Dimens.d16.responsive()),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacing(of: Dimens.d8.responsive()),
              Row(
                children: List.generate(10, (index) {
                  final starNumber = index + 1;
                  final isSelected = starNumber <= _selectedRating;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedRating = starNumber),
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
              Text(
                _selectedRating > 0 ? '$_selectedRating/10' : '0/10',
                style: AppTextStyles.style.s12.w400.coolGrayColor,
              ),
            ],
          ),

          VerticalSpacing(of: Dimens.d16.responsive()),

          TextFormField(
            controller: _commentController,
            style: AppTextStyles.style.s14.w400.whiteColor,
            maxLines: 4,
            minLines: 4,
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
    );
  }
}
