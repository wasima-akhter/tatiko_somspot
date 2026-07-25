class CompleteProfileResponse {
  final String id;
  final AuthInfo auth;
  final String name;
  final String email;
  final String language;
  final bool isOnline;
  final String profileImage;
  final LocationCoordinates locationCoordinates;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  CompleteProfileResponse({
    required this.id,
    required this.auth,
    required this.name,
    required this.email,
    required this.language,
    required this.isOnline,
    required this.profileImage,
    required this.locationCoordinates,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory CompleteProfileResponse.fromJson(Map<String, dynamic> json) {
    return CompleteProfileResponse(
      id: json["_id"] ?? "",
      auth: AuthInfo.fromJson(json["authId"] ?? {}),
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      language: json["language"] ?? "",
      isOnline: json["isOnline"] ?? false,
      profileImage: json["profile_image"] ?? "",
      locationCoordinates: LocationCoordinates.fromJson(
        json["locationCoordinates"] ?? {},
      ),
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      version: json["__v"] ?? 0,
    );
  }
}

class AuthInfo {
  final String id;
  final String name;
  final String email;
  final String language;
  final String role;
  final bool isBlocked;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  AuthInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.language,
    required this.role,
    required this.isBlocked,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory AuthInfo.fromJson(Map<String, dynamic> json) {
    return AuthInfo(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      language: json["language"] ?? "",
      role: json["role"] ?? "",
      isBlocked: json["isBlocked"] ?? false,
      isActive: json["isActive"] ?? false,
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      version: json["__v"] ?? 0,
    );
  }
}

class LocationCoordinates {
  final String type;
  final List<double> coordinates;

  LocationCoordinates({required this.type, required this.coordinates});

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) {
    return LocationCoordinates(
      type: json["type"] ?? "",
      coordinates: (json["coordinates"] as List<dynamic>? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }
}
