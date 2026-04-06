import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/booking_summary.dart';
import 'components/date_time_selector.dart';
import 'components/seats_grid.dart';
import 'cubit/book_tickets_cubit.dart';

class BookTicketsScreen extends StatefulWidget {
  final String movieId;
  final String movieTitle;
  final String cinemaName;
  final int pricePerSeat;

  const BookTicketsScreen({
    super.key,
    required this.movieId,
    required this.movieTitle,
    required this.cinemaName,
    this.pricePerSeat = 50000,
  });

  @override
  State<BookTicketsScreen> createState() => _BookTicketsScreenState();
}

class _BookTicketsScreenState extends State<BookTicketsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: BlocBuilder<BookTicketsCubit, BookTicketsState>(
        builder: (context, state) {
          return Container(
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
                                // Seats Section
                                SeatsGrid(
                                  seats: state.seats,
                                  selectedSeatIds: state.selectedSeatIds,
                                  onSeatTap: (seatId) {
                                    context.read<BookTicketsCubit>().selectSeat(seatId);
                                  },
                                ),
                                VerticalSpacing(of: Dimens.d32.responsive()),
                                // Date & Time Section
                                DateTimeSelector(
                                  selectedDate: state.selectedDate,
                                  selectedShowtime: state.selectedShowtime,
                                  onDateSelected: (date) {
                                    context.read<BookTicketsCubit>().selectDate(date);
                                  },
                                  onShowtimeSelected: (showtime) {
                                    context.read<BookTicketsCubit>().selectShowtime(showtime);
                                  },
                                ),
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
          );
        },
      ),
      extendBody: true,
      bottomNavigationBar: BookingSummary(
        selectedSeatsCount: 8,
        pricePerSeat: widget.pricePerSeat,
        isLoading: false,
        onBookPressed: () {},
      ),
    );
  }
}
