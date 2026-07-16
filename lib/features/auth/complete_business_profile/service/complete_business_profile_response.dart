class CompleteBusinessProfileResponse {
  final String id;
  final String owner;
  final String name;
  final String category;
  final String description;

  final String logo;
  final String coverImage;
  final List<String> gallery;

  final String phone;
  final String address;

  final BusinessLocation location;

  final List<BusinessOpeningHour> openingHours;

  final String timezone;
  final String status;

  final double ratingAvg;
  final int ratingCount;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  CompleteBusinessProfileResponse({
    required this.id,
    required this.owner,
    required this.name,
    required this.category,
    required this.description,
    required this.logo,
    required this.coverImage,
    required this.gallery,
    required this.phone,
    required this.address,
    required this.location,
    required this.openingHours,
    required this.timezone,
    required this.status,
    required this.ratingAvg,
    required this.ratingCount,
    this.createdAt,
    this.updatedAt,
  });

  factory CompleteBusinessProfileResponse.fromJson(Map<String, dynamic> json) {
    return CompleteBusinessProfileResponse(
      id: json["_id"]?.toString() ?? "",
      owner: json["owner"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      category: json["category"]?.toString() ?? "",
      description: json["description"]?.toString() ?? "",

      logo: json["logo"]?.toString() ?? "",
      coverImage: json["coverImage"]?.toString() ?? "",

      gallery: json["gallery"] != null
          ? List<String>.from(json["gallery"])
          : [],

      phone: json["phone"]?.toString() ?? "",
      address: json["address"]?.toString() ?? "",

      location: BusinessLocation.fromJson(json["location"] ?? {}),

      openingHours: json["openingHours"] != null
          ? List<BusinessOpeningHour>.from(
              json["openingHours"].map((e) => BusinessOpeningHour.fromJson(e)),
            )
          : [],

      timezone: json["timezone"]?.toString() ?? "",
      status: json["status"]?.toString() ?? "",

      ratingAvg: double.tryParse(json["ratingAvg"].toString()) ?? 0,

      ratingCount: int.tryParse(json["ratingCount"].toString()) ?? 0,

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,

      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
    );
  }
}

class BusinessLocation {
  final String type;
  final double longitude;
  final double latitude;

  BusinessLocation({
    required this.type,
    required this.longitude,
    required this.latitude,
  });

  factory BusinessLocation.fromJson(Map<String, dynamic> json) {
    final coordinates = json["coordinates"] ?? [];

    return BusinessLocation(
      type: json["type"]?.toString() ?? "Point",

      // GeoJSON order: [longitude, latitude]
      longitude: coordinates.isNotEmpty
          ? double.tryParse(coordinates[0].toString()) ?? 0
          : 0,

      latitude: coordinates.length > 1
          ? double.tryParse(coordinates[1].toString()) ?? 0
          : 0,
    );
  }
}

class BusinessOpeningHour {
  final String day;
  final String open;
  final String close;
  final bool closed;

  BusinessOpeningHour({
    required this.day,
    required this.open,
    required this.close,
    required this.closed,
  });

  factory BusinessOpeningHour.fromJson(Map<String, dynamic> json) {
    return BusinessOpeningHour(
      day: json["day"]?.toString() ?? "",
      open: json["open"]?.toString() ?? "",
      close: json["close"]?.toString() ?? "",
      closed: json["closed"] ?? false,
    );
  }
}
