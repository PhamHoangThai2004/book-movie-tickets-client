class BookingRequest {
  final String showtimeId;
  final String seatId;

  BookingRequest({required this.showtimeId, required this.seatId});

  Map<String, dynamic> toJson() => {'showtimeId': showtimeId, 'seatId': seatId};
}
