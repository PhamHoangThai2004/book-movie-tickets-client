class PaginationResponse<T> {
  final List<T> items;
  final int totalPages;
  final bool hasMore;
  final int page;
  final int pageSize;

  PaginationResponse({
    required this.items,
    required this.totalPages,
    required this.hasMore,
    required this.page,
    required this.pageSize,
  });

  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    final meta = json['meta'] as Map<String, dynamic>;
    return PaginationResponse(
      items: (json['data'] as List).map((e) => fromJsonT(e)).toList(),
      totalPages: meta['totalPage'],
      hasMore: meta['hasMore'],
      page: meta['page'],
      pageSize: meta['pageSize'],
    );
  }

  PaginationResponse<T> copyWith({
    List<T>? items,
    int? totalPages,
    bool? hasMore,
    int? page,
    int? pageSize,
  }) {
    return PaginationResponse(
      items: items ?? this.items,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
