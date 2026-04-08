import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/data/enums/seat_status_enum.dart';
import 'package:client/data/enums/seat_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/showtime_model.dart';
import '../../../generated/assets.gen.dart';
import '../cubit/book_tickets_cubit.dart';

class SeatsGrid extends StatelessWidget {
  const SeatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: Dimens.d345.responsive(),
              height: Dimens.d2.responsive(),
              decoration: BoxDecoration(
                color: AppColors.amberYellow,
                borderRadius: BorderRadius.circular(Dimens.d3.responsive()),
              ),
            ),
            Assets.images.imgProjectorRange.image(),
            VerticalSpacing(of: Dimens.d24.responsive()),
          ],
        ),
        _buildSeatsGrid(context),
        VerticalSpacing(of: Dimens.d24.responsive()),
        _buildLegend(),
      ],
    );
  }

  Widget _buildSeatsGrid(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<BookTicketsCubit, BookTicketsState>(
        buildWhen: (p, c) => p.showtime != c.showtime || p.selectedSeatIds != c.selectedSeatIds,
        builder: (context, state) {
          final seats = state.showtime?.seats ?? [];
          const int seatsPerRow = 10;
          List<List<Seat>> rows = [];
          for (var i = 0; i < seats.length; i += seatsPerRow) {
            rows.add(
              seats.sublist(i, i + seatsPerRow > seats.length ? seats.length : i + seatsPerRow),
            );
          }

          return Column(
            children: rows.map((rowSeats) {
              return Padding(
                padding: EdgeInsets.only(bottom: Dimens.d8.responsive()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rowSeats.map((seat) {
                    final isSelected = state.selectedSeatIds.contains(seat.id);
                    return _buildSeatButton(
                      context,
                      seat: seat,
                      isSelected: isSelected,
                      onTap: () => context.bookTicketsCubit.selectSeat(seat.id),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildSeatButton(
    BuildContext context, {
    required Seat seat,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    bool isClickable = true;

    if (seat.status.isAvailable) {
    } else if (seat.status.isReserved || seat.status.isBooked) {
      isClickable = false;
    }

    if (isSelected) {
      isClickable = true;
    }

    return CupertinoButtonCustom(
      onPressed: isClickable ? onTap : null,
      child: Container(
        width: Dimens.d32.responsive(),
        height: Dimens.d32.responsive(),
        margin: EdgeInsets.symmetric(horizontal: Dimens.d4.responsive()),
        decoration: BoxDecoration(
          color: seat.status.background(seat.seatType),
          borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
        ),
        alignment: Alignment.center,
        child: Text(
          seat.seatCode,
          style: AppTextStyles.style.s12.w400.copyWith(color: seat.status.color(seat.seatType)),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(
          label: SeatStatusEnum.available.name(SeatTypeEnum.normal),
          color: SeatStatusEnum.available.background(SeatTypeEnum.normal),
        ),
        HorizontalSpacing(of: Dimens.d24.responsive()),
        _buildLegendItem(
          label: SeatStatusEnum.available.name(SeatTypeEnum.vip),
          color: SeatStatusEnum.available.background(SeatTypeEnum.vip),
        ),
        HorizontalSpacing(of: Dimens.d24.responsive()),
        _buildLegendItem(
          label: SeatStatusEnum.reserved.name(SeatTypeEnum.normal),
          color: SeatStatusEnum.reserved.background(SeatTypeEnum.normal),
        ),
        HorizontalSpacing(of: Dimens.d24.responsive()),
        _buildLegendItem(
          label: SeatStatusEnum.booked.name(SeatTypeEnum.normal),
          color: SeatStatusEnum.booked.background(SeatTypeEnum.normal),
        ),
      ],
    );
  }

  Widget _buildLegendItem({required String label, required Color color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Dimens.d24.responsive(),
          height: Dimens.d24.responsive(),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
          ),
        ),
        HorizontalSpacing(of: Dimens.d8.responsive()),
        Text(label, style: AppTextStyles.style.s14.w400.whiteSmokeColor),
      ],
    );
  }
}
