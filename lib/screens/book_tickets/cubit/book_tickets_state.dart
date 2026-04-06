part of 'book_tickets_cubit.dart';

enum SeatType { available, reserved, selected }

class SeatState {
  final String id;
  final SeatType type;

  SeatState({required this.id, required this.type});

  SeatState copyWith({String? id, SeatType? type}) {
    return SeatState(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }
}

class BookTicketsState {
  final List<SeatState> seats;
  final List<String> selectedSeatIds;
  final DateTime? selectedDate;
  final String? selectedShowtime;
  final StatusEnum status;
  final String errorMessage;

  const BookTicketsState({
    this.seats = const [],
    this.selectedSeatIds = const [],
    this.selectedDate,
    this.selectedShowtime,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
  });

  BookTicketsState copyWith({
    List<SeatState>? seats,
    List<String>? selectedSeatIds,
    DateTime? selectedDate,
    String? selectedShowtime,
    StatusEnum? status,
    String? errorMessage,
  }) {
    return BookTicketsState(
      seats: seats ?? this.seats,
      selectedSeatIds: selectedSeatIds ?? this.selectedSeatIds,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedShowtime: selectedShowtime ?? this.selectedShowtime,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  double calculateTotalPrice({required double pricePerSeat}) {
    return selectedSeatIds.length * pricePerSeat;
  }
}


