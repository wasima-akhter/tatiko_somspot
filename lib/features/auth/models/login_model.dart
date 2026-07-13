class LoginResponse {
  final int statusCode;
  final bool success;
  final String message;
  final LoginData? data;

  const LoginResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const LoginResponse(
        statusCode: 0,
        success: false,
        message: '',
        data: null,
      );
    }

    return LoginResponse(
      statusCode: json['statusCode'] is int
          ? json['statusCode']
          : int.tryParse('${json['statusCode']}') ?? 0,
      success: json['success'] is bool ? json['success'] : false,
      message: json['message']?.toString() ?? '',
      data: json['data'] is Map<String, dynamic>
          ? LoginData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class LoginData {
  final String accessToken;
  final String refreshToken;

  const LoginData({required this.accessToken, required this.refreshToken});

  factory LoginData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const LoginData(accessToken: '', refreshToken: '');
    }

    return LoginData(
      accessToken: json['accessToken']?.toString() ?? '',
      refreshToken: json['refreshToken']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'accessToken': accessToken, 'refreshToken': refreshToken};
  }
}
