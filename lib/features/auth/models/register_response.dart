class RegisterResponse {
  final int statusCode;
  final bool success;
  final String message;
  final RegisterData? data;

  const RegisterResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const RegisterResponse(statusCode: 0, success: false, message: '');
    }

    return RegisterResponse(
      statusCode: json["statusCode"] ?? 0,
      success: json["success"] ?? false,
      message: json["message"]?.toString() ?? "",
      data: json["data"] != null ? RegisterData.fromJson(json["data"]) : null,
    );
  }
}

class RegisterData {
  final bool isActive;
  final String message;

  const RegisterData({required this.isActive, required this.message});

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      isActive: json["isActive"] ?? false,
      message: json["message"]?.toString() ?? "",
    );
  }
}
