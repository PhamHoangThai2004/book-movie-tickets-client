import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/model/showtime_preview_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/date_time_utils.dart';
import '../../../data/model/booking_preview_model.dart';
import '../../../data/model/movie_model.dart';
import '../../../data/model/showtime_model.dart';
import '../../../data/network/exceptions/api_exception.dart';
import '../../../data/remote/requests/booking_request.dart';
import '../../../data/remote/requests/showtime_request.dart';
import '../../../data/repositories/showtime_repository.dart';

part 'book_tickets_state.dart';

class BookTicketsCubit extends Cubit<BookTicketsState> {
  final ShowtimeRepository showtimeRepository;
  final MovieModel movie;
  final String cinemaId;

  BookTicketsCubit({required this.showtimeRepository, required this.movie, required this.cinemaId})
    : super(BookTicketsState(selectedDate: DateTime.now()));

  Future<void> fetchShowtimes() async {
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final request = ShowtimeRequest(
        cinemaId: cinemaId,
        movieId: movie.id,
        page: 1,
        size: 10,
        date: DateTimeUtils.toIso8601(state.selectedDate.toString(), sourceFormat: 'yyyy-MM-dd'),
      );
      final response = await showtimeRepository.getShowtimes(request);

      if (response.isEmpty) {
        emit(state.setSelectedShowtime(null));
      } else {
        emit(state.setSelectedShowtime(response.first.id));
      }

      emit(state.copyWith(showtimes: response, status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> fetchShowtimeDetail() async {
    final showtimeId = state.selectedShowtimeId;
    if (showtimeId == null) return;
    emit(state.copyWith(loadShowtime: StatusEnum.processing));
    try {
      final response = await showtimeRepository.getShowtimeById(showtimeId);
      emit(state.copyWith(showtime: response, loadShowtime: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(loadShowtime: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> _pickSeat(String seatId) async {
    if (state.showtime == null) return;
    emit(state.copyWith(seatStatus: StatusEnum.initial));
    try {
      final request = BookingRequest(showtimeId: state.showtime!.id, seatId: seatId);
      final response = await showtimeRepository.pickSeat(request);
      emit(state.copyWith(booking: response));
    } on ApiException catch (e) {
      _reloadShowtime();
      emit(state.copyWith(seatStatus: StatusEnum.failure, errorMessage: e.errorMessage));
      debugPrint(e.errorMessage);
    }
  }

  Future<void> _unpickSeat(String seatId) async {
    if (state.showtime == null) return;
    emit(state.copyWith(seatStatus: StatusEnum.initial));
    try {
      final request = BookingRequest(showtimeId: state.showtime!.id, seatId: seatId);
      final response = await showtimeRepository.unpickSeat(request);
      emit(state.copyWith(booking: response));
    } on ApiException catch (e) {
      _reloadShowtime();
      emit(state.copyWith(seatStatus: StatusEnum.failure, errorMessage: e.errorMessage));
      debugPrint(e.errorMessage);
    }
  }

  void toggleSeat(String seatId, bool isSelected) async {
    if (isSelected) {
      await _unpickSeat(seatId);
    } else {
      await _pickSeat(seatId);
    }
    _reloadShowtime();
  }

  void _reloadShowtime() async {
    try {
      final response = await showtimeRepository.getShowtimeById(state.selectedShowtimeId!);
      emit(state.copyWith(showtime: response));
    } on ApiException catch (e) {
      debugPrint(e.errorMessage);
    }
  }

  void selectDate(DateTime date) async {
    emit(state.copyWith(selectedDate: date));
    await removePendingBooking();
    fetchShowtimes();
  }

  void selectShowtime(String showtimeId) async {
    emit(state.copyWith(selectedShowtimeId: showtimeId));
    await removePendingBooking();
    fetchShowtimeDetail();
  }

  Future<void> removePendingBooking() async {
    try {
      await showtimeRepository.removePendingBooking();
      emit(state.resetBooking());
    } on ApiException catch (e) {
      debugPrint(e.errorMessage);
    }
  }
}
