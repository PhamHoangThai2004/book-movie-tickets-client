import 'package:client/data/enums/status_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_tickets_state.dart';

class BookTicketsCubit extends Cubit<BookTicketsState> {
  BookTicketsCubit() : super(const BookTicketsState()) {
    _initializeSeats();
  }

  void _initializeSeats() {
    // Mock data: 13 rows x 13 columns = 169 seats
    List<SeatState> seats = [];
    final rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M'];
    
    for (int i = 0; i < rows.length; i++) {
      for (int j = 1; j <= 13; j++) {
        final seatId = '${rows[i]}$j';
        // Mock: some seats are reserved
        final isReserved = (i == 5 && j >= 5 && j <= 8) || (i == 6 && j >= 4 && j <= 9);
        seats.add(
          SeatState(
            id: seatId,
            type: isReserved ? SeatType.reserved : SeatType.available,
          ),
        );
      }
    }
    
    emit(state.copyWith(seats: seats));
  }

  void selectSeat(String seatId) {
    final seat = state.seats.firstWhere((s) => s.id == seatId);
    
    if (seat.type == SeatType.reserved) {
      return; // Cannot select reserved seat
    }

    List<String> updatedSelectedIds = List.from(state.selectedSeatIds);
    
    if (updatedSelectedIds.contains(seatId)) {
      updatedSelectedIds.remove(seatId);
      
      // Update seat type back to available
      List<SeatState> updatedSeats = state.seats.map((s) {
        return s.id == seatId ? s.copyWith(type: SeatType.available) : s;
      }).toList();
      emit(state.copyWith(seats: updatedSeats, selectedSeatIds: updatedSelectedIds));
    } else {
      updatedSelectedIds.add(seatId);
      
      // Update seat type to selected
      List<SeatState> updatedSeats = state.seats.map((s) {
        return s.id == seatId ? s.copyWith(type: SeatType.selected) : s;
      }).toList();
      emit(state.copyWith(seats: updatedSeats, selectedSeatIds: updatedSelectedIds));
    }
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectShowtime(String showtime) {
    emit(state.copyWith(selectedShowtime: showtime));
  }

  double getTotalPrice({required double pricePerSeat}) {
    return state.calculateTotalPrice(pricePerSeat: pricePerSeat);
  }

  Future<void> confirmBooking() async {
    if (state.selectedSeatIds.isEmpty || state.selectedDate == null || state.selectedShowtime == null) {
      emit(state.copyWith(
        status: StatusEnum.failure,
        errorMessage: 'Please select seats, date and showtime',
      ));
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing));
    try {
      // Mock API call
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: StatusEnum.success));
    } catch (e) {
      emit(state.copyWith(
        status: StatusEnum.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}

