import 'dart:io';

class InfluencerCompleteProfileRequest {
  final String name;
  final String address;
  final String phoneNumber;
  final File profileImage;

  InfluencerCompleteProfileRequest({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.profileImage,
  });
}
