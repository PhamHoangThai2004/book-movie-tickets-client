class BookingPreviewModel {
  final String id;
  final String bookingCode;
  final int totalAmount;
  final String status;
  final String createdAt;
  final List<TicketInfo> tickets;

  BookingPreviewModel({
    required this.id,
    required this.bookingCode,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.tickets,
  });

  factory BookingPreviewModel.fromJson(Map<String, dynamic> json) {
    return BookingPreviewModel(
      id: json['id'] as String,
      bookingCode: json['bookingCode'] as String,
      totalAmount: json['totalAmount'] as int,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      tickets: List<TicketInfo>.from(json["tickets"].map((x) => TicketInfo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingCode': bookingCode,
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt,
      "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
    };
  }
}

class TicketInfo {
  final String id;
  final String ticketCode;
  final int price;
  final String expiredAt;
  final String status;
  final String seatCode;

  TicketInfo({
    required this.id,
    required this.ticketCode,
    required this.price,
    required this.expiredAt,
    required this.status,
    required this.seatCode,
  });

  factory TicketInfo.fromJson(Map<String, dynamic> json) => TicketInfo(
    id: json["id"],
    ticketCode: json["ticketCode"],
    price: json["price"],
    expiredAt: json["expiredAt"],
    status: json["status"],
    seatCode: json["seatCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticketCode": ticketCode,
    "price": price,
    "expiredAt": expiredAt,
    "status": status,
    "seatCode": seatCode,
  };
}
