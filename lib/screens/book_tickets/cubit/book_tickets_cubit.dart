import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/model/showtime_preview_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/date_time_utils.dart';
import '../../../data/enums/seat_status_enum.dart';
import '../../../data/enums/seat_type_enum.dart';
import '../../../data/model/movie_model.dart';
import '../../../data/model/showtime_model.dart';
import '../../../data/network/exceptions/api_exception.dart';
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

  void selectSeat(String seatId) {
    if (state.showtime == null) return;

    final seatIndex = state.showtime!.seats.indexWhere((s) => s.id == seatId);
    if (seatIndex == -1) return;

    final seat = state.showtime!.seats[seatIndex];

    if (seat.status.isReserved || seat.status.isBooked) {
      return;
    }

    List<String> updatedSelectedIds = List.from(state.selectedSeatIds);
    List<Seat> updatedSeats = List.from(state.showtime!.seats);

    if (updatedSelectedIds.contains(seatId)) {
      updatedSelectedIds.remove(seatId);
      updatedSeats[seatIndex] = seat.copyWith(status: SeatStatusEnum.available);
    } else {
      updatedSelectedIds.add(seatId);
      updatedSeats[seatIndex] = seat.copyWith(status: SeatStatusEnum.reserved);
    }

    emit(
      state.copyWith(
        selectedSeatIds: updatedSelectedIds,
        showtime: state.showtime!.copyWith(seats: updatedSeats),
      ),
    );
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
    fetchShowtimes();
  }

  void selectShowtime(String showtimeId) {
    emit(state.copyWith(selectedShowtimeId: showtimeId));
    fetchShowtimeDetail();
  }

  double getTotalPrice() {
    return state.calculateTotalPrice();
  }

  Future<void> confirmBooking() async {
    if (state.selectedSeatIds.isEmpty ||
        state.selectedDate == null ||
        state.selectedShowtimeId == null) {
      emit(
        state.copyWith(
          status: StatusEnum.failure,
          errorMessage: 'Please select seats, date and showtime',
        ),
      );
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: StatusEnum.success));
    } catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.toString()));
    }
  }
}
