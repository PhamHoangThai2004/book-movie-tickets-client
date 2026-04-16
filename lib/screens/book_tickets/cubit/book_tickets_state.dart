part of 'book_tickets_cubit.dart';

class BookTicketsState {
  final List<ShowtimePreviewModel> showtimes;
  final ShowtimeModel? showtime;
  final DateTime? selectedDate;
  final String? selectedShowtimeId;
  final StatusEnum status;
  final StatusEnum loadShowtime;
  final String errorMessage;
  final BookingPreviewModel? booking;
  final StatusEnum seatStatus;

  const BookTicketsState({
    this.showtimes = const [],
    this.showtime,
    this.loadShowtime = StatusEnum.initial,
    this.selectedDate,
    this.selectedShowtimeId,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.seatStatus = StatusEnum.initial,
    this.booking,
  });

  BookTicketsState copyWith({
    List<ShowtimePreviewModel>? showtimes,
    ShowtimeModel? showtime,
    StatusEnum? loadShowtime,
    DateTime? selectedDate,
    String? selectedShowtimeId,
    StatusEnum? status,
    String? errorMessage,
    int? totalAmount,
    StatusEnum? seatStatus,
    BookingPreviewModel? booking,
  }) {
    return BookTicketsState(
      showtimes: showtimes ?? this.showtimes,
      showtime: showtime ?? this.showtime,
      loadShowtime: loadShowtime ?? this.loadShowtime,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedShowtimeId: selectedShowtimeId ?? this.selectedShowtimeId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      seatStatus: seatStatus ?? this.seatStatus,
      booking: booking ?? this.booking,
    );
  }

  BookTicketsState setSelectedShowtime(String? showtimeId) {
    return BookTicketsState(
      showtimes: showtimes,
      showtime: showtimeId != null ? showtime : null,
      loadShowtime: loadShowtime,
      selectedDate: selectedDate,
      selectedShowtimeId: showtimeId,
      status: status,
      errorMessage: errorMessage,
      booking: null
    );
  }

  BookTicketsState resetBooking() => BookTicketsState(
    showtimes: showtimes,
    showtime: showtime,
    loadShowtime: loadShowtime,
    selectedDate: selectedDate,
    selectedShowtimeId: selectedShowtimeId,
    status: status,
    errorMessage: errorMessage,
    booking: null
  );
}
