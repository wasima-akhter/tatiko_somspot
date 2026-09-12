import 'dart:io';

class InfluencerCompleteProfileRequest {
  final String name;
  final String address;
  final String phoneNumber;
  final File profileImage;
  final double? latitude;
  final double? longitude;

  InfluencerCompleteProfileRequest({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.profileImage,
    this.latitude,
    this.longitude,
  });
}
