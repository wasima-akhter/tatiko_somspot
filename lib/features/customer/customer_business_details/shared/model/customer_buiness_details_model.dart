class BusinessDetailsModel {
  final String id;
  final String owner;
  final String name;
  final BusinessCategoryModel? category;
  final String description;
  final String logo;
  final String coverImage;
  final List<String> gallery;
  final String phone;
  final String whatsapp;
  final String address;
  final BusinessLocationModel? location;
  final List<OpeningHourModel> openingHours;
  final String timezone;
  final String status;
  final double ratingAvg;
  final int ratingCount;
  final String createdAt;
  final String updatedAt;
  final bool isOpen;
  final String? closesAt;
  final String? opensAt;

  BusinessDetailsModel({
    required this.id,
    required this.owner,
    required this.name,
    required this.category,
    required this.description,
    required this.logo,
    required this.coverImage,
    required this.gallery,
    required this.phone,
    required this.whatsapp,
    required this.address,
    required this.location,
    required this.openingHours,
    required this.timezone,
    required this.status,
    required this.ratingAvg,
    required this.ratingCount,
    required this.createdAt,
    required this.updatedAt,
    required this.isOpen,
    required this.closesAt,
    required this.opensAt,
  });

  factory BusinessDetailsModel.fromJson(Map<String, dynamic> json) {
    return BusinessDetailsModel(
      id: json['_id']?.toString() ?? '',
      owner: json['owner']?.toString() ?? '',
      name: json['name']?.toString() ?? '',

      // Handles:
      // null
      // "Restaurant"
      // { "name": "Restaurant" }
      category: json['category'] != null
          ? BusinessCategoryModel.fromJson(
              json['category'] as Map<String, dynamic>,
            )
          : null,

      description: json['description']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      coverImage: json['coverImage']?.toString() ?? '',

      gallery: _parseGallery(json['gallery']),

      phone: json['phone']?.toString() ?? '',
      whatsapp: json['whatsapp']?.toString() ?? '',
      address: json['address']?.toString() ?? '',

      location: json['location'] is Map<String, dynamic>
          ? BusinessLocationModel.fromJson(
              json['location'] as Map<String, dynamic>,
            )
          : null,

      openingHours: _parseOpeningHours(json['openingHours']),

      timezone: json['timezone']?.toString() ?? '',
      status: json['status']?.toString() ?? '',

      ratingAvg: (json['ratingAvg'] as num?)?.toDouble() ?? 0.0,

      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,

      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',

      isOpen: json['isOpen'] as bool? ?? false,

      closesAt: json['closesAt']?.toString(),
      opensAt: json['opensAt']?.toString(),
    );
  }

  static List<String> _parseGallery(dynamic value) {
    if (value is! List) {
      return [];
    }

    return value
        .map((e) {
          if (e is String) {
            return e;
          }

          if (e is Map<String, dynamic>) {
            return e['url']?.toString() ??
                e['image']?.toString() ??
                e['path']?.toString() ??
                '';
          }

          return '';
        })
        .where((e) => e.isNotEmpty)
        .toList();
  }

  static List<OpeningHourModel> _parseOpeningHours(dynamic value) {
    if (value is! List) {
      return [];
    }

    return value
        .whereType<Map<String, dynamic>>()
        .map((e) => OpeningHourModel.fromJson(e))
        .toList();
  }
}

class BusinessCategoryModel {
  final String id;
  final String name;
  final String slug;
  final String icon;

  BusinessCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
  });

  factory BusinessCategoryModel.fromJson(Map<String, dynamic> json) {
    return BusinessCategoryModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }
}

class BusinessLocationModel {
  final String type;
  final List<double> coordinates;

  BusinessLocationModel({required this.type, required this.coordinates});

  factory BusinessLocationModel.fromJson(Map<String, dynamic> json) {
    return BusinessLocationModel(
      type: json['type']?.toString() ?? '',
      coordinates: json['coordinates'] is List
          ? (json['coordinates'] as List)
                .whereType<num>()
                .map((e) => e.toDouble())
                .toList()
          : [],
    );
  }
}

class OpeningHourModel {
  final String day;
  final String open;
  final String close;
  final bool closed;

  OpeningHourModel({
    required this.day,
    required this.open,
    required this.close,
    required this.closed,
  });

  factory OpeningHourModel.fromJson(Map<String, dynamic> json) {
    return OpeningHourModel(
      day: json['day']?.toString() ?? '',
      open: json['open']?.toString() ?? '',
      close: json['close']?.toString() ?? '',
      closed: json['closed'] as bool? ?? false,
    );
  }
}
