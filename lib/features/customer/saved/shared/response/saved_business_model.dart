class SavedBusinessModel {
  final String id;
  final String userId;
  final SavedBusinessInfo? business;

  SavedBusinessModel({required this.id, required this.userId, this.business});

  factory SavedBusinessModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SavedBusinessModel(id: '', userId: '', business: null);
    }

    return SavedBusinessModel(
      id: json['_id']?.toString() ?? '',
      userId: json['user']?.toString() ?? '',
      business: json['business'] is Map
          ? SavedBusinessInfo.fromJson(
              Map<String, dynamic>.from(json['business']),
            )
          : null,
    );
  }
}

class SavedBusinessInfo {
  final String id;
  final String name;
  final String logo;
  final String address;
  final double ratingAvg;
  final int ratingCount;

  SavedBusinessInfo({
    required this.id,
    required this.name,
    required this.logo,
    required this.address,
    required this.ratingAvg,
    required this.ratingCount,
  });

  factory SavedBusinessInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SavedBusinessInfo(
        id: '',
        name: '',
        logo: '',
        address: '',
        ratingAvg: 0.0,
        ratingCount: 0,
      );
    }

    return SavedBusinessInfo(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      ratingAvg: _parseDouble(json['ratingAvg']),
      ratingCount: _parseInt(json['ratingCount']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString()) ?? 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value.toString()) ?? 0;
  }
}
