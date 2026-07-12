class RegisterRequest {
  final String role;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequest({
    required this.role,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "role": role,
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
    };
  }
}
