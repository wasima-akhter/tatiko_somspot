import 'dart:io';

import '../../../utils/multipart/multipart_body.dart';

class EditProfileRequest {
  final String name;
  final String phone;
  final File? profileImage;

  final String? address;

  final double? lng;
  final double? lat;
  EditProfileRequest({
    required this.name,
    required this.phone,
    this.profileImage,
    this.address,
    this.lng,
    this.lat,
  });

  Map<String, String> fields() {
    final fields = <String, String>{'name': name, 'phone': phone};

    if (address != null) {
      fields['address'] = address!;
    }

    if (lng != null) {
      fields['lng'] = lng.toString();
    }

    if (lat != null) {
      fields['lat'] = lat.toString();
    }

    return fields;
  }

  List<MultipartBody> files() {
    if (profileImage == null) {
      return [];
    }

    return [MultipartBody(fieldKey: "profile_image", file: profileImage!)];
  }
}
