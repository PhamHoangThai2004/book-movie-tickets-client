import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/common/register_cubit.dart';
import '../../core/styles/app_text_styles.dart';
import 'components/booking_summary.dart';
import 'components/date_time_selector.dart';
import 'components/seats_grid.dart';
import 'cubit/book_tickets_cubit.dart';

class BookTicketsScreen extends StatefulWidget {
  const BookTicketsScreen({super.key});

  @override
  State<BookTicketsScreen> createState() => _BookTicketsScreenState();
}

class _BookTicketsScreenState extends State<BookTicketsScreen> {
  @override
  void initState() {
    super.initState();
    context.bookTicketsCubit.removePendingBooking();
    context.bookTicketsCubit.fetchShowtimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: MultiBlocListener(
        listeners: [
          BlocListener<BookTicketsCubit, BookTicketsState>(
            listenWhen: (p, c) => p.status != c.status,
            listener: (context, state) {
              if (state.status.isFailure) {
                LoadingCustom.hideLoading();
                ToastCustom.show(message: state.errorMessage);
              } else if (state.status.isProcessing) {
                LoadingCustom.show();
              } else if (state.status.isSuccess) {
                LoadingCustom.hideLoading();
                if (state.selectedShowtimeId != null) {
                  context.bookTicketsCubit.fetchShowtimeDetail();
                }
              } else {
                LoadingCustom.hideLoading();
              }
            },
          ),
          BlocListener<BookTicketsCubit, BookTicketsState>(
            listenWhen: (p, c) => p.loadShowtime != c.loadShowtime,
            listener: (context, state) {
              if (state.loadShowtime.isProcessing) {
                LoadingCustom.show();
              } else if (state.loadShowtime.isSuccess) {
                LoadingCustom.hideLoading();
              } else if (state.loadShowtime.isFailure) {
                LoadingCustom.hideLoading();
                ToastCustom.show(message: state.errorMessage);
              } else {
                LoadingCustom.hideLoading();
              }
            },
          ),
          BlocListener<BookTicketsCubit, BookTicketsState>(
            listenWhen: (p, c) => p.seatStatus != c.seatStatus,
            listener: (context, state) {
              if (state.seatStatus.isFailure) {
                ToastCustom.show(message: state.errorMessage);
              }
            },
          ),
        ],
        child: Container(
          decoration: AppThemes.mainBackground,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
              child: Column(
                children: [
                  VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                  HeaderCustom(title: 'book_tickets'.tr()),
                  VerticalSpacing(of: Dimens.d20.responsive()),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SeatsGrid(),
                              VerticalSpacing(of: Dimens.d32.responsive()),
                              DateTimeSelector(),
                              VerticalSpacing(of: Dimens.d20.responsive()),
                              _bookingInfo(),
                              VerticalSpacing(of: Dimens.d20.responsive()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BookingSummary(),
    );
  }

  Widget _bookingInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive(), vertical: Dimens.d16.responsive()),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimens.d20.responsive()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('showtime_info'.tr(), style: AppTextStyles.style.s24.w700.whiteColor),
          VerticalSpacing(of: Dimens.d16.responsive()),
          Text(
            context.bookTicketsCubit.state.cinemaName,
            style: AppTextStyles.style.s16.w500.whiteColor,
          ),
          VerticalSpacing(of: Dimens.d16.responsive()),
          Text(
            '${'movie'.tr()}: ${context.bookTicketsCubit.state.movieTitle}',
            style: AppTextStyles.style.s16.w500.whiteColor,
          ),
        ],
      ),
    );
  }
}
