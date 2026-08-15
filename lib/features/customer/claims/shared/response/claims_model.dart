// -----------------------------------------------------------------------------
// 1. Claim Wallet Models (`claim_wallet_model.dart`)
// -----------------------------------------------------------------------------
class ClaimWalletItemModel {
  final String id;
  final String code;
  final String status;
  final ClaimedOfferInfo? offer;
  final ClaimedBusinessInfo? business;
  final DateTime? expiresAt;

  ClaimWalletItemModel({
    required this.id,
    required this.code,
    required this.status,
    this.offer,
    this.business,
    this.expiresAt,
  });

  factory ClaimWalletItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ClaimWalletItemModel(id: '', code: '', status: '');
    }

    return ClaimWalletItemModel(
      id: json['_id']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      offer: json['offer'] is Map
          ? ClaimedOfferInfo.fromJson(Map<String, dynamic>.from(json['offer']))
          : null,
      business: json['business'] is Map
          ? ClaimedBusinessInfo.fromJson(
              Map<String, dynamic>.from(json['business']),
            )
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'].toString())
          : null,
    );
  }
}

class ClaimedOfferInfo {
  final String id;
  final String title;
  final String discountLabel;
  final String offerImage;

  ClaimedOfferInfo({
    required this.id,
    required this.title,
    required this.discountLabel,
    required this.offerImage,
  });

  factory ClaimedOfferInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ClaimedOfferInfo(
        id: '',
        title: '',
        discountLabel: '',
        offerImage: '',
      );
    }

    return ClaimedOfferInfo(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      discountLabel: json['discountLabel']?.toString() ?? '',
      offerImage: json['offerImage']?.toString() ?? '',
    );
  }
}

class ClaimedBusinessInfo {
  final String id;
  final String name;
  final String logo;

  ClaimedBusinessInfo({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory ClaimedBusinessInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ClaimedBusinessInfo(id: '', name: '', logo: '');
    }

    return ClaimedBusinessInfo(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
    );
  }
}
