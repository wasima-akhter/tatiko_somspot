class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}

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

class VerifyOtpRequest {
  final String email;
  final String activationCode;

  VerifyOtpRequest({required this.email, required this.activationCode});

  Map<String, dynamic> toJson() => {
    "email": email,
    "activationCode": activationCode,
  };
}

class ResendOtpRequest {
  final String email;

  ResendOtpRequest({required this.email});

  Map<String, dynamic> toJson() => {"email": email};
}

class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}

class VerifyForgotPasswordOtpRequest {
  final String email;
  final String code;

  VerifyForgotPasswordOtpRequest({required this.email, required this.code});

  Map<String, dynamic> toJson() {
    return {"email": email, "code": code};
  }
}

class ResetPasswordRequest {
  final String email;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequest({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };
  }
}

class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };
  }
}
