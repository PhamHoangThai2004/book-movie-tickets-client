import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DateTimeSelector extends StatefulWidget {
  final DateTime? selectedDate;
  final String? selectedShowtime;
  final Function(DateTime) onDateSelected;
  final Function(String) onShowtimeSelected;

  const DateTimeSelector({
    super.key,
    required this.selectedDate,
    required this.selectedShowtime,
    required this.onDateSelected,
    required this.onShowtimeSelected,
  });

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
        Text('Select Date & Time', style: AppTextStyles.style.s24.w700.whiteColor),
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
      child: Row(
        children: List.generate(7, (index) {
          final date = _currentDate.add(Duration(days: index));
          final isSelected = widget.selectedDate?.year == date.year &&
              widget.selectedDate?.month == date.month &&
              widget.selectedDate?.day == date.day;

          return Padding(
            padding: EdgeInsets.only(right: Dimens.d12.responsive()),
            child: _buildDateButton(date: date, isSelected: isSelected),
          );
        }),
      ),
    );
  }

  Widget _buildDateButton({required DateTime date, required bool isSelected}) {
    final dayName = DateFormat('EEE', 'en').format(date); // Mon, Tue, etc.
    final dayNum = DateFormat('dd').format(date);
    final monthAbbr = DateFormat('MMM').format(date); // Jan, Feb, etc.

    return GestureDetector(
      onTap: () => widget.onDateSelected(date),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.d16.responsive(),
          vertical: Dimens.d12.responsive(),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.amberYellow : const Color(0xFF1D1D1D),
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
          border: isSelected
              ? Border.all(color: AppColors.amberYellow, width: 2)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: AppTextStyles.style.s12.w400.copyWith(
                color: isSelected ? AppColors.black : AppColors.coolGray,
              ),
            ),
            VerticalSpacing(of: Dimens.d4.responsive()),
            Text(
              dayNum,
              style: AppTextStyles.style.s16.w700.copyWith(
                color: isSelected ? AppColors.black : AppColors.whiteSmoke,
              ),
            ),
            VerticalSpacing(of: Dimens.d4.responsive()),
            Text(
              monthAbbr,
              style: AppTextStyles.style.s12.w400.copyWith(
                color: isSelected ? AppColors.black : AppColors.coolGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowtimeSelector() {
    final showtimes = ['11:05', '14:15', '16:30', '20:00'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(showtimes.length, (index) {
          final showtime = showtimes[index];
          final isSelected = widget.selectedShowtime == showtime;

          return Padding(
            padding: EdgeInsets.only(right: Dimens.d12.responsive()),
            child: _buildShowtimeButton(
              showtime: showtime,
              isSelected: isSelected,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildShowtimeButton({
    required String showtime,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => widget.onShowtimeSelected(showtime),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.d20.responsive(),
          vertical: Dimens.d12.responsive(),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.amberYellow : const Color(0xFF1D1D1D),
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
          border: isSelected
              ? Border.all(color: AppColors.amberYellow, width: 2)
              : null,
        ),
        child: Text(
          showtime,
          style: AppTextStyles.style.s14.w600.copyWith(
            color: isSelected ? AppColors.black : AppColors.whiteSmoke,
          ),
        ),
      ),
    );
  }
}



