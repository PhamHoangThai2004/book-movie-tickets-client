class TicketRequest {
  final int page;
  final int size;

  TicketRequest({this.page = 1, this.size = 10});

  Map<String, dynamic> toJson() => {'page': page, 'size': size};
}
