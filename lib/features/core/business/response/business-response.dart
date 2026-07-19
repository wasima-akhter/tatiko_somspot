import '../../../../share/model/pagination_meta_model.dart';

class BusinessModel {
  final String id;
  final String name;
  final String description;
  final String logo;
  final String coverImage;
  final String phone;
  final String address;
  final String status;
  final double ratingAvg;
  final int ratingCount;
  final bool isOpen;

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
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      logo: json["logo"] ?? "",
      coverImage: json["coverImage"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      status: json["status"] ?? "",
      ratingAvg: (json["ratingAvg"] ?? 0).toDouble(),
      ratingCount: json["ratingCount"] ?? 0,
      isOpen: json["isOpen"] ?? false,
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
