class VerifyOtpRequest {
  final String email;
  final String type;
  final String otpCode;

  VerifyOtpRequest({required this.email, required this.type, required this.otpCode});

  Map<String, String> toJson() => {'email': email, 'type': type, 'otpCode': otpCode};
}
