import 'dart:io';

class CompleteProfileRequest {
  final String name;
  final File profileImage;

  CompleteProfileRequest({required this.name, required this.profileImage});
}
