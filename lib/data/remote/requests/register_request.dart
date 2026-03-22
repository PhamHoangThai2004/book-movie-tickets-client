class RegisterRequest {
  final String email;
  final String password;
  final String name;

  RegisterRequest({required this.email, required this.password, required this.name});

  Map<String, String> toJson() => {'email': email, 'password': password, 'name': name};
}
