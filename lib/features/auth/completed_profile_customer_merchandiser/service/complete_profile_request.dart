import 'dart:io';

class CompleteProfileRequest {
  final String name;
  final String phoneNumber;
  final File profileImage;

  CompleteProfileRequest({
    required this.name,
    required this.profileImage,
    required this.phoneNumber,
  });
}
