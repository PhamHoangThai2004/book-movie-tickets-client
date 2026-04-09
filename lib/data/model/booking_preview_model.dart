class BookingPreviewModel {
  final String id;
  final String bookingCode;
  final int totalAmount;
  final String status;
  final String createdAt;

  BookingPreviewModel({
    required this.id,
    required this.bookingCode,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  factory BookingPreviewModel.fromJson(Map<String, dynamic> json) {
    return BookingPreviewModel(
      id: json['id'] as String,
      bookingCode: json['bookingCode'] as String,
      totalAmount: json['totalAmount'] as int,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingCode': bookingCode,
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
