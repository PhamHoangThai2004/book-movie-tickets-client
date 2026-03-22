import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/navigation/navigation_service.dart';
import '../../core/themes/app_themes.dart';
import '../../generated/assets.gen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _posters = [
    'https://i.ebayimg.com/images/g/pREAAOSw9~Vf0U2S/s-l1200.jpg',
    'https://m.media-amazon.com/images/I/71ni36WICrL._AC_UF894,1000_QL80_.jpg',
    'https://m.media-amazon.com/images/I/91wnf9kI7sL._AC_UF1000,1000_QL80_.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.amberYellow.withValues(alpha: 0.1),
      body: SafeArea(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPosterCarousel(),
                  VerticalSpacing(of: Dimens.d30.responsive()),
                  _buildWelcomeText(),
                  VerticalSpacing(of: Dimens.d12.responsive()),
                  _buildPageIndicator(),
                ],
              ),
            ),
            _buildActionButtons(),
            VerticalSpacing(of: Dimens.d20.responsive()),
            _buildFooterText(),
            VerticalSpacing(of: Dimens.d20.responsive()),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterCarousel() {
    return SizedBox(
      height: Dimens.d350.responsive(),
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: _posters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.d40.responsive()),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Image.network(_posters[index], fit: BoxFit.cover),
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

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _posters.length,
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
          ButtonCustom(title: 'sign_in'.tr(), onPressed: () {
            context.pushNamed(NavigationService.signIn);
          }),
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
