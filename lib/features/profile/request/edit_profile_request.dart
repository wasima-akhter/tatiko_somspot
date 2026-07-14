import 'dart:io';

import '../../../utils/multipart/multipart_body.dart';

class EditProfileRequest {
  final String name;
  final String phone;
  final File? profileImage;


  EditProfileRequest({
    required this.name,
    required this.phone,
    this.profileImage,
  });


  Map<String, String> fields() {
    return {
      "name": name,
      "phone": phone,
    };
  }


  List<MultipartBody> files() {

    if (profileImage == null) {
      return [];
    }

    return [
      MultipartBody(
        fieldKey: "profile_image",
        file: profileImage!,
      ),
    ];
  }
}
