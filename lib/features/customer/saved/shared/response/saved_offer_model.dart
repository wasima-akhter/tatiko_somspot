class SavedOfferModel {
  final String id;
  final String userId;
  final SavedOfferInfo? offer;

  SavedOfferModel({required this.id, required this.userId, this.offer});

  factory SavedOfferModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SavedOfferModel(id: '', userId: '', offer: null);
    }

    return SavedOfferModel(
      id: json['_id']?.toString() ?? '',
      userId: json['user']?.toString() ?? '',
      offer: json['offer'] is Map
          ? SavedOfferInfo.fromJson(Map<String, dynamic>.from(json['offer']))
          : null,
    );
  }
}

class SavedOfferInfo {
  final String id;
  final String title;
  final String discountLabel;
  final String offerImage;
  final DateTime? endAt;
  final SavedOfferBusiness? business;

  SavedOfferInfo({
    required this.id,
    required this.title,
    required this.discountLabel,
    required this.offerImage,
    required this.endAt,
    this.business,
  });

  factory SavedOfferInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SavedOfferInfo(
        id: '',
        title: '',
        discountLabel: '',
        offerImage: '',
        endAt: null,
        business: null,
      );
    }

    return SavedOfferInfo(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      discountLabel: json['discountLabel']?.toString() ?? '',
      offerImage: json['offerImage']?.toString() ?? '',
      endAt: _parseDateTime(json['endAt']),
      business: json['business'] is Map
          ? SavedOfferBusiness.fromJson(
              Map<String, dynamic>.from(json['business']),
            )
          : null,
    );
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }
}

class SavedOfferBusiness {
  final String id;
  final String name;
  final String logo;

  SavedOfferBusiness({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory SavedOfferBusiness.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SavedOfferBusiness(id: '', name: '', logo: '');
    }

    return SavedOfferBusiness(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
    );
  }
}
