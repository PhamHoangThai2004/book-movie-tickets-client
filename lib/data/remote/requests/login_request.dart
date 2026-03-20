class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, String> toJson() => {'email': email, 'password': password};
}
