import 'dart:io';

class CompleteBusinessProfileRequest {
  final String name;
  final String category;
  final String description;
  final String phone;
  final String address;

  final double lng;
  final double lat;

  final List<Map<String, dynamic>> openingHours;

  final File logo;
  final File coverImage;
  final List<File>? gallery;

  CompleteBusinessProfileRequest({
    required this.name,
    required this.category,
    required this.description,
    required this.phone,
    required this.address,
    required this.lng,
    required this.lat,
    required this.openingHours,
    required this.logo,
    required this.coverImage,
    this.gallery,
  });
}
