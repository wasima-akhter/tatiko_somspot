class GetProfileModel {
  final String id;
  final AuthGetProfileModel? auth;
  final String name;
  final String email;
  final String language;
  final String role;
  final bool isOnline;
  final bool isBlocked;
  final bool isActive;
  final String? phone;
  final String? profileImage;
  final String? address;
  final LocationCoordinates? locationCoordinates;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int savedCount;
  final int claimsCount;
  final int reviewsCount;

  GetProfileModel({
    required this.id,
    this.auth,
    required this.name,
    required this.email,
    required this.language,
    required this.role,
    required this.isOnline,
    required this.isBlocked,
    required this.isActive,
    this.phone,
    this.profileImage,
    this.address,
    this.locationCoordinates,
    this.createdAt,
    this.updatedAt,
    this.savedCount = 0,
    this.claimsCount = 0,
    this.reviewsCount = 0,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) {
    final authJson = json["authId"];

    return GetProfileModel(
      id: json["_id"] ?? "",

      auth: authJson != null ? AuthGetProfileModel.fromJson(authJson) : null,

      name: json["name"] ?? authJson?["name"] ?? "",

      email: json["email"] ?? authJson?["email"] ?? "",

      language: json["language"] ?? authJson?["language"] ?? "en",

      role: json["role"] ?? authJson?["role"] ?? "",

      isOnline: json["isOnline"] ?? false,

      isBlocked: authJson?["isBlocked"] ?? false,

      isActive: authJson?["isActive"] ?? false,

      phone: json["phoneNumber"] ?? json["phone"],

      profileImage: json["profile_image"]?.toString().replaceAll("\\", "/"),

      address: json["address"],

      locationCoordinates: json["locationCoordinates"] != null
          ? LocationCoordinates.fromJson(json["locationCoordinates"])
          : null,

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,

      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,

      savedCount: json["savedCount"] ?? 0,
      claimsCount: json["claimsCount"] ?? 0,
      reviewsCount: json["reviewsCount"] ?? 0,
    );
  }
}

class AuthGetProfileModel {
  final String id;
  final String name;
  final String email;
  final String language;
  final String role;
  final bool isBlocked;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AuthGetProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.language,
    required this.role,
    required this.isBlocked,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthGetProfileModel.fromJson(Map<String, dynamic> json) {
    return AuthGetProfileModel(
      id: json["_id"] ?? "",

      name: json["name"] ?? "",

      email: json["email"] ?? "",

      language: json["language"] ?? "en",

      role: json["role"] ?? "",

      isBlocked: json["isBlocked"] ?? false,

      isActive: json["isActive"] ?? false,

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,

      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
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

      coordinates:
          (json["coordinates"] as List?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
    );
  }
}
