part of 'book_tickets_cubit.dart';

class BookTicketsState {
  final List<ShowtimePreviewModel> showtimes;
  final ShowtimeModel? showtime;
  final List<String> selectedSeatIds;
  final DateTime? selectedDate;
  final String? selectedShowtimeId;
  final StatusEnum status;
  final StatusEnum loadShowtime;
  final String errorMessage;

  const BookTicketsState({
    this.showtimes = const [],
    this.showtime,
    this.loadShowtime = StatusEnum.initial,
    this.selectedSeatIds = const [],
    this.selectedDate,
    this.selectedShowtimeId,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
  });

  BookTicketsState copyWith({
    List<ShowtimePreviewModel>? showtimes,
    ShowtimeModel? showtime,
    StatusEnum? loadShowtime,
    List<String>? selectedSeatIds,
    DateTime? selectedDate,
    String? selectedShowtimeId,
    StatusEnum? status,
    String? errorMessage,
  }) {
    return BookTicketsState(
      showtimes: showtimes ?? this.showtimes,
      showtime: showtime ?? this.showtime,
      loadShowtime: loadShowtime ?? this.loadShowtime,
      selectedSeatIds: selectedSeatIds ?? this.selectedSeatIds,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedShowtimeId: selectedShowtimeId ?? this.selectedShowtimeId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  BookTicketsState setSelectedShowtime(String? showtimeId) {
    return BookTicketsState(
      showtimes: showtimes,
      showtime: showtimeId != null ? showtime : null,
      loadShowtime: loadShowtime,
      selectedSeatIds: showtimeId != null ? selectedSeatIds : [],
      selectedDate: selectedDate,
      selectedShowtimeId: showtimeId,
      status: status,
      errorMessage: errorMessage,
    );
  }

  double calculateTotalPrice() {
    if (showtime == null) return 0;
    double total = 0;
    for (final seatId in selectedSeatIds) {
      final seat = showtime!.seats.firstWhere(
        (s) => s.id == seatId,
        orElse: () => Seat(
          id: '',
          seatCode: '',
          seatType: SeatTypeEnum.normal,
          price: 0,
          status: SeatStatusEnum.available,
        ),
      );
      total += seat.price;
    }
    return total;
  }
}
