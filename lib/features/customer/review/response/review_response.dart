class BusinessReviewModel {
  final String id;
  final ReviewUserModel user;
  final double rating;
  final String review;
  final int helpfulCount;
  final DateTime? createdAt;

  BusinessReviewModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.review,
    required this.helpfulCount,
    this.createdAt,
  });

  factory BusinessReviewModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};

    return BusinessReviewModel(
      id: data['_id']?.toString() ?? '',
      user: ReviewUserModel.fromJson(
        data['user'] is Map ? Map<String, dynamic>.from(data['user']) : null,
      ),
      rating: _toDouble(data['rating']),
      review: data['review']?.toString() ?? '',
      helpfulCount: _toInt(data['helpfulCount']),
      createdAt: _parseDate(data['createdAt']),
    );
  }
}

class ReviewUserModel {
  final String id;
  final String name;
  final String profileImage;

  ReviewUserModel({
    required this.id,
    required this.name,
    required this.profileImage,
  });

  factory ReviewUserModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};

    return ReviewUserModel(
      id: data['_id']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
      profileImage: data['profile_image']?.toString() ?? '',
    );
  }
}

class MyReviewModel {
  final String id;
  final ReviewBusinessModel business;
  final double rating;
  final String review;
  final DateTime? createdAt;

  MyReviewModel({
    required this.id,
    required this.business,
    required this.rating,
    required this.review,
    this.createdAt,
  });

  factory MyReviewModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};

    return MyReviewModel(
      id: data['_id']?.toString() ?? '',
      business: ReviewBusinessModel.fromJson(
        data['business'] is Map
            ? Map<String, dynamic>.from(data['business'])
            : null,
      ),
      rating: _toDouble(data['rating']),
      review: data['review']?.toString() ?? '',
      createdAt: _parseDate(data['createdAt']),
    );
  }
}

class ReviewBusinessModel {
  final String id;
  final String name;
  final String logo;

  ReviewBusinessModel({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory ReviewBusinessModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};

    return ReviewBusinessModel(
      id: data['_id']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
      logo: data['logo']?.toString() ?? '',
    );
  }
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;

  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value.toString()) ?? 0.0;
}

int _toInt(dynamic value) {
  if (value == null) return 0;

  if (value is int) return value;

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value.toString()) ?? 0;
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;

  return DateTime.tryParse(value.toString());
}
