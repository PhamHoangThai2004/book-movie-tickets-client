import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/customs/images/image_custom.dart';
import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/customs/toasts/toast_custom.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/themes/app_themes.dart';
import '../../data/model/movie_poster_preview_model.dart';
import '../../generated/assets.gen.dart';
import 'cubit/auth_cubit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getMoviePreviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.amberYellow.withValues(alpha: 0.1),
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isProcessing) {
              LoadingCustom.show();
            } else if (state.status.isSuccess && state.movie != null) {
              LoadingCustom.hideLoading();
              context.pushNamed(NavigationService.movieDetail, extra: state.movie);
            } else if (state.status.isFailure) {
              LoadingCustom.hideLoading();
              ToastCustom.show(message: state.errorMessage);
            } else {
              LoadingCustom.hideLoading();
            }
          },
          child: Column(
            children: [
              VerticalSpacing(of: Dimens.d30.responsive()),
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.appDefaultPadding),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Assets.images.imgNameApp.image(
                    width: Dimens.d204.responsive(),
                    height: Dimens.d36.responsive(),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state.movies.isEmpty) {
                      return Center(child: CircularProgressIndicator(color: AppColors.amberYellow));
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPosterCarousel(state.movies),
                        VerticalSpacing(of: Dimens.d30.responsive()),
                        _buildWelcomeText(),
                        VerticalSpacing(of: Dimens.d12.responsive()),
                        _buildPageIndicator(state.movies.length),
                      ],
                    );
                  },
                ),
              ),
              _buildActionButtons(),
              VerticalSpacing(of: Dimens.d20.responsive()),
              _buildFooterText(),
              VerticalSpacing(of: Dimens.d20.responsive()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPosterCarousel(List<MoviePosterPreviewModel> movies) {
    return SizedBox(
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
          final poster = movies[index].poster;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.d40.responsive()),
            child: CupertinoButtonCustom(
              onPressed: () => context.read<AuthCubit>().getMovieDetail(movies[index].id),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.d30.responsive()),
                child: ImageCustom(
                  imageUrl: poster,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: Container(
                    color: AppColors.grey,
                    child: Center(child: Assets.svgs.icPicture.svg()),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.d30.responsive()),
      child: Column(
        children: [
          Text('cinema_hub_hello'.tr(), style: AppTextStyles.style.w700.s32.whiteSmokeColor),
          VerticalSpacing(of: Dimens.d12.responsive()),
          Text(
            'enjoy_your_favorite_movies'.tr(),
            style: AppTextStyles.style.w400.s16.whiteSmokeColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.d4.responsive()),
          width: Dimens.d8.responsive(),
          height: Dimens.d8.responsive(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? AppColors.amberYellow : AppColors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
      child: Column(
        children: [
          ButtonCustom(
            title: 'sign_in'.tr(),
            onPressed: () {
              context.pushNamed(NavigationService.signIn);
            },
          ),
          VerticalSpacing(of: Dimens.d16.responsive()),
          ButtonCustom(
            title: 'sign_up'.tr(),
            onPressed: () {
              context.pushNamed(NavigationService.signUp);
            },
            buttonStyle: AppThemes.outlineButtonStyle,
            titleStyle: AppTextStyles.style.w700.s20.whiteSmokeColor,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.d40.responsive()),
      child: Text(
        'privacy_policy_message'.tr(),
        textAlign: TextAlign.center,
        style: AppTextStyles.style.w400.s12.coolGrayColor,
      ),
    );
  }
}
