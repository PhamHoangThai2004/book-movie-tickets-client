class BookingPreviewModel {
  final String id;
  final String bookingCode;
  final int totalAmount;
  final String status;
  final String createdAt;
  final List<SeatBookingInfo> seatBookings;

  BookingPreviewModel({
    required this.id,
    required this.bookingCode,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.seatBookings,
  });

  factory BookingPreviewModel.fromJson(Map<String, dynamic> json) {
    return BookingPreviewModel(
      id: json['id'] as String,
      bookingCode: json['bookingCode'] as String,
      totalAmount: json['totalAmount'] as int,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      seatBookings: List<SeatBookingInfo>.from(json["seatBookings"].map((x) => SeatBookingInfo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingCode': bookingCode,
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt,
      "seatBookings": List<dynamic>.from(seatBookings.map((x) => x.toJson())),
    };
  }
}

class SeatBookingInfo {
  final String id;
  final int price;
  final String holdExpiredAt;
  final String status;
  final String seatCode;

  SeatBookingInfo({
    required this.id,
    required this.price,
    required this.holdExpiredAt,
    required this.status,
    required this.seatCode,
  });

  factory SeatBookingInfo.fromJson(Map<String, dynamic> json) => SeatBookingInfo(
    id: json["id"],
    price: json["price"],
    holdExpiredAt: json["holdExpiredAt"],
    status: json["status"],
    seatCode: json["seatCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "expiredAt": holdExpiredAt,
    "status": status,
    "seatCode": seatCode,
  };
}
