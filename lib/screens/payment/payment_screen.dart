import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/images/image_custom.dart';
import 'package:client/core/customs/toasts/shimmer_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/core/utils/string_utils.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:client/screens/payment/components/payment_loading_shimmer.dart';
import 'package:client/screens/payment/cubit/payment_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/common/register_cubit.dart';
import '../../data/model/booking_model.dart';
import '../../generated/assets.gen.dart';

class PaymentScreen extends StatefulWidget {
  final String bookingId;

  const PaymentScreen({super.key, required this.bookingId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = 'ZaloPay';

  @override
  void initState() {
    super.initState();
    context.paymentCubit.getBookingDetail(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: ShimmerEffect(
        child: Container(
          decoration: AppThemes.mainBackground,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
              child: Column(
                children: [
                  VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                  HeaderCustom(title: 'pay'.tr()),
                  VerticalSpacing(of: Dimens.d20.responsive()),
                  Expanded(
                    child: BlocBuilder<PaymentCubit, PaymentState>(
                      buildWhen: (previous, current) =>
                          previous.booking != current.booking || previous.status != current.status,
                      builder: (context, state) {
                        if (state.status.isProcessing) {
                          return const PaymentLoadingShimmer();
                        } else if (state.status == StatusEnum.failure) {
                          return Center(
                            child: Text(
                              state.errorMessage,
                              style: AppTextStyles.style.s16.whiteColor,
                            ),
                          );
                        } else if (state.status.isSuccess) {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMoviePaymentInfo(state.booking!),
                                VerticalSpacing(of: Dimens.d24.responsive()),
                                _buildOrderInfo(state.booking!),
                                VerticalSpacing(of: Dimens.d14.responsive()),
                                Divider(
                                  color: AppColors.darkCharcoal,
                                  thickness: Dimens.d1.responsive(),
                                ),
                                VerticalSpacing(of: Dimens.d14.responsive()),
                                _buildTotalSection(state.booking!.totalAmount),
                                VerticalSpacing(of: Dimens.d24.responsive()),
                                Text(
                                  'payment_method'.tr(),
                                  style: AppTextStyles.style.s18.w700.whiteColor,
                                ),
                                VerticalSpacing(of: Dimens.d16.responsive()),
                                _buildPaymentMethods(),
                                VerticalSpacing(of: Dimens.d24.responsive()),
                                _buildCountdownTimer(),
                                VerticalSpacing(of: Dimens.d24.responsive()),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  _buildContinueButton(),
                  VerticalSpacing(of: Dimens.d24.responsive()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoviePaymentInfo(BookingModel booking) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.obsidian,
        borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Dimens.d16.responsive()),
              topLeft: Radius.circular(Dimens.d16.responsive()),
            ),
            child: ImageCustom(
              imageUrl: booking.movie.poster,
              width: Dimens.d120.responsive(),
              height: Dimens.d161.responsive(),
              fit: BoxFit.cover,
            ),
          ),
          HorizontalSpacing(of: Dimens.d16.responsive()),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.movie.title,
                  style: AppTextStyles.style.s20.w700.amberYellowColor,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                VerticalSpacing(of: Dimens.d8.responsive()),
                _buildInfoRow(Assets.svgs.icVideoPlay, booking.movie.genres.first.name),
                VerticalSpacing(of: Dimens.d6.responsive()),
                _buildInfoRow(Assets.svgs.icLocation, booking.cinema.address),
                VerticalSpacing(of: Dimens.d6.responsive()),
                _buildInfoRow(
                  Assets.svgs.icClock,
                  '${DateTimeUtils.fromIso8601(booking.showtime.showDate, targetFormat: 'dd.MM.yyyy')} • ${DateTimeUtils.fromIso8601(booking.showtime.startTime, targetFormat: 'HH:mm')}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(SvgGenImage icon, String text) {
    return Row(
      children: [
        icon.svg(),
        HorizontalSpacing(of: Dimens.d8.responsive()),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.style.s12.w400.coolGrayColor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderInfo(BookingModel? booking) {
    return Column(
      children: [
        _buildOrderRow('order_id'.tr(), booking?.bookingCode ?? ''),
        VerticalSpacing(of: Dimens.d12.responsive()),
        _buildOrderRow('seat'.tr(), booking?.tickets.map((t) => t.seatCode).join(', ') ?? ''),
      ],
    );
  }

  Widget _buildOrderRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.style.s16.w400.whiteSmokeColor),
        Text(value, style: AppTextStyles.style.s16.w700.whiteSmokeColor),
      ],
    );
  }

  Widget _buildTotalSection(int totalAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('total_amount'.tr(), style: AppTextStyles.style.s16.w400.whiteSmokeColor),
        Text(
          StringUtils.formatVND(totalAmount),
          style: AppTextStyles.style.s24.w700.amberYellowColor,
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      margin: EdgeInsets.only(bottom: Dimens.d12.responsive()),
      padding: EdgeInsets.all(Dimens.d16.responsive()),
      decoration: BoxDecoration(
        color: AppColors.amberYellow.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
        border: Border.all(color: AppColors.amberYellow, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: Dimens.d60.responsive(),
            height: Dimens.d40.responsive(),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
            ),
            padding: EdgeInsets.all(Dimens.d4.responsive()),
            child: Assets.images.imgVnpay.image(),
          ),
          HorizontalSpacing(of: Dimens.d16.responsive()),
          Text('vn_pay'.tr(), style: AppTextStyles.style.s16.w500.whiteColor),
          const Spacer(),
          Assets.svgs.icArrowRight.svg(),
        ],
      ),
    );
  }

  Widget _buildCountdownTimer() {
    return Container(
      padding: EdgeInsets.all(Dimens.d16.responsive()),
      decoration: BoxDecoration(
        color: AppColors.amberYellow.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('complete_payment_in'.tr(), style: AppTextStyles.style.s16.w500.whiteSmokeColor),
          Text('15:00', style: AppTextStyles.style.s16.w700.amberYellowColor),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return BlocBuilder<PaymentCubit, PaymentState>(
      buildWhen: (previous, current) => previous.booking != current.booking,
      builder: (context, state) {
        if (state.booking == null) {
          return Container();
        }
        return ButtonCustom(
          title: 'continue'.tr(),
          onPressed: () {},
          titleStyle: AppTextStyles.style.s18.w700.blackColor,
        );
      },
    );
  }
}
