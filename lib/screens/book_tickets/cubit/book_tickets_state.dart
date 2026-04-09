part of 'book_tickets_cubit.dart';

class BookTicketsState {
  final List<ShowtimePreviewModel> showtimes;
  final ShowtimeModel? showtime;
  final DateTime? selectedDate;
  final String? selectedShowtimeId;
  final StatusEnum status;
  final StatusEnum loadShowtime;
  final String errorMessage;
  final int totalAmount;

  const BookTicketsState({
    this.totalAmount = 0,
    this.showtimes = const [],
    this.showtime,
    this.loadShowtime = StatusEnum.initial,
    this.selectedDate,
    this.selectedShowtimeId,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
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
  }) {
    return BookTicketsState(
      showtimes: showtimes ?? this.showtimes,
      showtime: showtime ?? this.showtime,
      loadShowtime: loadShowtime ?? this.loadShowtime,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedShowtimeId: selectedShowtimeId ?? this.selectedShowtimeId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      totalAmount: totalAmount ?? this.totalAmount,
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
      totalAmount: 0,
    );
  }
}
