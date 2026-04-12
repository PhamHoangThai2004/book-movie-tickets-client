import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/utils/date_time_utils.dart';
import 'package:client/screens/book_tickets/cubit/book_tickets_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/customs/buttons/button_custom.dart';
import '../../../data/model/showtime_preview_model.dart';

class DateTimeSelector extends StatefulWidget {
  const DateTimeSelector({super.key});

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('select_showtime'.tr(), style: AppTextStyles.style.s24.w700.whiteColor),
        VerticalSpacing(of: Dimens.d16.responsive()),
        _buildDateSelector(),
        VerticalSpacing(of: Dimens.d20.responsive()),
        _buildShowtimeSelector(),
      ],
    );
  }

  Widget _buildDateSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<BookTicketsCubit, BookTicketsState>(
        buildWhen: (p, c) => p.selectedDate != c.selectedDate,
        builder: (context, state) {
          return Row(
            children: List.generate(28, (index) {
              final date = _currentDate.add(Duration(days: index));
              final isSelected =
                  state.selectedDate?.year == date.year &&
                  state.selectedDate?.month == date.month &&
                  state.selectedDate?.day == date.day;

              return Padding(
                padding: EdgeInsets.only(right: Dimens.d12.responsive()),
                child: _buildDateButton(date: date, isSelected: isSelected),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildDateButton({required DateTime date, required bool isSelected}) {
    final dayNum = DateFormat('dd').format(date);
    final monthAbbr = DateFormat('MMM').format(date);

    String getVietnameseWeekday(int weekday) {
      switch (weekday) {
        case DateTime.monday:
          return 'T2';
        case DateTime.tuesday:
          return 'T3';
        case DateTime.wednesday:
          return 'T4';
        case DateTime.thursday:
          return 'T5';
        case DateTime.friday:
          return 'T6';
        case DateTime.saturday:
          return 'T7';
        case DateTime.sunday:
          return 'CN';
        default:
          return '';
      }
    }

    return CupertinoButtonCustom(
      onPressed: () {
        if (!isSelected) {
          context.bookTicketsCubit.selectDate(date);
        }
      },
      child: Container(
        width: Dimens.d55.responsive(),
        height: Dimens.d130.responsive(),
        padding: EdgeInsets.symmetric(vertical: Dimens.d10.responsive()),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.amberYellow : AppColors.obsidian,
          borderRadius: BorderRadius.circular(Dimens.d37.responsive()),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              monthAbbr,
              style: AppTextStyles.style.s14.w500.copyWith(
                color: isSelected ? AppColors.black : AppColors.whiteSmoke,
              ),
            ),
            Container(
              width: Dimens.d42.responsive(),
              height: Dimens.d42.responsive(),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.graphite : AppColors.carbonGray,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(dayNum, style: AppTextStyles.style.s16.w700.whiteSmokeColor),
            ),
            Text(
              getVietnameseWeekday(date.weekday),
              style: AppTextStyles.style.s14.w500.copyWith(
                color: isSelected ? AppColors.black : AppColors.whiteSmoke,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowtimeSelector() {
    return BlocBuilder<BookTicketsCubit, BookTicketsState>(
      buildWhen: (p, c) =>
          p.showtimes != c.showtimes || p.selectedShowtimeId != c.selectedShowtimeId,
      builder: (context, state) {
        final showtimes = state.showtimes;

        if (showtimes.isEmpty) {
          return Center(
            child: Column(
              spacing: Dimens.d10.responsive(),
              children: [
                Text(
                  'showtime_not_found'.tr(),
                  style: AppTextStyles.style.s16.w500.amberYellowColor,
                ),
                ButtonCustom(
                  title: 'find_day_have_showtimes'.tr(),
                  onPressed: () {},
                  titleStyle: AppTextStyles.style.s14.w500.blackColor,
                  width: Dimens.d200.responsive(),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(showtimes.length, (index) {
              final showtime = showtimes[index];
              final isSelected = state.selectedShowtimeId == showtime.id;

              return Padding(
                padding: EdgeInsets.only(right: Dimens.d12.responsive()),
                child: _buildShowtimeButton(showtime: showtime, isSelected: isSelected),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildShowtimeButton({required ShowtimePreviewModel showtime, required bool isSelected}) {
    return CupertinoButtonCustom(
      onPressed: () {
        if (!isSelected) {
          context.bookTicketsCubit.selectShowtime(showtime.id);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.d26.responsive(),
          vertical: Dimens.d10.responsive(),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.amberYellow.withValues(alpha: 0.1) : AppColors.obsidian,
          borderRadius: BorderRadius.circular(Dimens.d31.responsive()),
          border: Border.all(
            color: isSelected ? AppColors.amberYellow : AppColors.obsidian,
            width: 0.5,
          ),
        ),
        child: Text(
          DateTimeUtils.fromIso8601(showtime.startTime, targetFormat: 'HH:mm'),
          style: AppTextStyles.style.s16.w500.whiteSmokeColor,
        ),
      ),
    );
  }
}
