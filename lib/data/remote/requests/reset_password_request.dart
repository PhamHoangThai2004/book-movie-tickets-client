class ResetPasswordRequest {
  final String email;
  final String password;
  final String verifyToken;

  ResetPasswordRequest({required this.email, required this.password, required this.verifyToken});

  Map<String, String> toJson() => {
    'email': email,
    'password': password,
    'verifyToken': verifyToken,
  };
}
