class LoginModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final UserModel user;

  LoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory LoginModel.fake() {
    return LoginModel(
      accessToken: 'fake_access_token_123456789',
      refreshToken: 'fake_refresh_token_987654321',
      tokenType: 'Bearer',
      expiresIn: 3600,
      user: UserModel.fake(),
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      tokenType: json['token_type'] ?? 'Bearer',
      expiresIn: json['expires_in'] ?? 0,
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user.toJson(),
    };
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String userRole;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.userRole,
  });

  factory UserModel.fake() {
    return UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: '+8801700000000',
      avatar: 'https://example.com/avatar.png',
      userRole: 'Customer',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatar: json['avatar'] ?? '',
      userRole: json['userRole'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
    };
  }
}
