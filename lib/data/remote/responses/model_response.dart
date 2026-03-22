class ModelResponse<T> {
  final bool success;
  final String message;
  final T data;

  ModelResponse({required this.success, required this.message, required this.data});

  factory ModelResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return ModelResponse<T>(
      success: json['success'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }
}
