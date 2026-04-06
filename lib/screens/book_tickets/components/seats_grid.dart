import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';
import '../cubit/book_tickets_cubit.dart';

class SeatsGrid extends StatelessWidget {
  final List<SeatState> seats;
  final List<String> selectedSeatIds;
  final Function(String) onSeatTap;

  const SeatsGrid({
    super.key,
    required this.seats,
    required this.selectedSeatIds,
    required this.onSeatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Screen representation
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
        // Seats grid
        _buildSeatsGrid(context),
        VerticalSpacing(of: Dimens.d24.responsive()),
        // Legend
        _buildLegend(),
      ],
    );
  }

  Widget _buildSeatsGrid(BuildContext context) {
    final rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M'];
    final seatsPerRow = 13;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: List.generate(rows.length, (rowIndex) {
          final row = rows[rowIndex];
          return Padding(
            padding: EdgeInsets.only(bottom: Dimens.d8.responsive()),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Dimens.d30.responsive(),
                  child: Text(
                    row,
                    style: AppTextStyles.style.s12.w400.coolGrayColor,
                    textAlign: TextAlign.center,
                  ),
                ),
                ...List.generate(seatsPerRow, (colIndex) {
                  final seatId = '$row${colIndex + 1}';
                  final seat = seats.firstWhere(
                    (s) => s.id == seatId,
                    orElse: () => SeatState(id: seatId, type: SeatType.available),
                  );
                  final isSelected = selectedSeatIds.contains(seatId);

                  return _buildSeatButton(
                    context,
                    seat: seat,
                    isSelected: isSelected,
                    onTap: () => onSeatTap(seatId),
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSeatButton(
    BuildContext context, {
    required SeatState seat,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    Color backgroundColor;

    switch (seat.type) {
      case SeatType.available:
        backgroundColor = AppColors.darkGray;
        break;
      case SeatType.reserved:
        backgroundColor = const Color(0xFF4A4A4A);
        break;
      case SeatType.selected:
        backgroundColor = AppColors.amberYellow;
        break;
    }

    final isClickable = seat.type != SeatType.reserved;

    return GestureDetector(
      onTap: isClickable ? onTap : null,
      child: Container(
        width: Dimens.d28.responsive(),
        height: Dimens.d28.responsive(),
        margin: EdgeInsets.symmetric(horizontal: Dimens.d4.responsive()),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
          border: isSelected ? Border.all(color: AppColors.amberYellow, width: 2) : null,
        ),
        child: seat.type == SeatType.reserved
            ? Icon(Icons.close, color: AppColors.coolGray, size: Dimens.d14.responsive())
            : null,
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(label: 'Available', color: AppColors.darkGray),
        HorizontalSpacing(of: Dimens.d24.responsive()),
        _buildLegendItem(label: 'Reserved', color: const Color(0xFF4A4A4A)),
        HorizontalSpacing(of: Dimens.d24.responsive()),
        _buildLegendItem(label: 'Selected', color: AppColors.amberYellow),
      ],
    );
  }

  Widget _buildLegendItem({required String label, required Color color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Dimens.d16.responsive(),
          height: Dimens.d16.responsive(),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Dimens.d4.responsive()),
          ),
        ),
        HorizontalSpacing(of: Dimens.d8.responsive()),
        Text(label, style: AppTextStyles.style.s12.w400.coolGrayColor),
      ],
    );
  }
}
