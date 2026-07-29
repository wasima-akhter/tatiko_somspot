import '../../../../share/model/pagination_meta_model.dart';

class BusinessModel {
  final String id;
  final String name;
  final String description;
  final String logo;
  final String coverImage;
  final String phone;
  final String whatsapp;
  final String address;
  final String status;
  final double ratingAvg;
  final int ratingCount;
  final bool isOpen;
  final String categoryId;
  final List<String> gallery;
  final List<BusinessHourModel> openingHours;

  final double latitude;
  final double longitude;

  final String city;

  BusinessModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.coverImage,
    required this.phone,
    required this.address,
    required this.status,
    required this.ratingAvg,
    required this.ratingCount,
    required this.isOpen,
    required this.categoryId,
    required this.gallery,
    required this.openingHours,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.whatsapp,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    final coordinates =
        (json["location"]?["coordinates"] as List<dynamic>? ?? []);

    return BusinessModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      logo: json["logo"] ?? "",
      coverImage: json["coverImage"] ?? "",
      phone: json["phone"] ?? "",
      whatsapp: json["whatsapp"] ?? "",
      address: json["address"] ?? "",
      status: json["status"] ?? "",
      ratingAvg: (json["ratingAvg"] ?? 0).toDouble(),
      ratingCount: json["ratingCount"] ?? 0,
      isOpen: json["isOpen"] ?? false,

      categoryId: json["category"] ?? "",

      gallery: List<String>.from(json["gallery"] ?? []),

      openingHours: (json["openingHours"] as List<dynamic>? ?? [])
          .map((e) => BusinessHourModel.fromJson(e))
          .toList(),

      longitude: coordinates.isNotEmpty
          ? (coordinates[0] as num).toDouble()
          : 0,

      latitude: coordinates.length > 1 ? (coordinates[1] as num).toDouble() : 0,

      city: json["timezone"] ?? "",
    );
  }
}

class BusinessHourModel {
  final String day;
  final String open;
  final String close;
  final bool closed;

  BusinessHourModel({
    required this.day,
    required this.open,
    required this.close,
    required this.closed,
  });

  factory BusinessHourModel.fromJson(Map<String, dynamic> json) {
    return BusinessHourModel(
      day: json["day"] ?? "",
      open: json["open"] ?? "",
      close: json["close"] ?? "",
      closed: json["closed"] ?? false,
    );
  }
}

class BusinessPaginationResponse {
  final List<BusinessModel> businesses;
  final PaginationMeta meta;

  BusinessPaginationResponse({required this.businesses, required this.meta});

  factory BusinessPaginationResponse.fromJson(Map<String, dynamic> json) {
    return BusinessPaginationResponse(
      businesses: (json["result"] as List? ?? [])
          .map((e) => BusinessModel.fromJson(e))
          .toList(),

      meta: PaginationMeta.fromJson(json["meta"]),
    );
  }
}
