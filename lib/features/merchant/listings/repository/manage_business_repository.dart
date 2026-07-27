import 'dart:io';

import 'package:som_spot/share/export/repo_export.dart';

import '../../../../utils/multipart/multipart_body.dart';

class ManageBusinessRepository {
  final ApiClient _apiClient;

  ManageBusinessRepository(this._apiClient);

  // ===============================
  // Update Business Information
  // ===============================

  Future<Response> updateBusiness({
    required Map<String, dynamic> data,

    File? logo,

    File? coverImage,

    List<File>? gallery,
  }) {
    final files = <MultipartBody>[];

    if (logo != null) {
      files.add(MultipartBody(fieldKey: "logo", file: logo));
    }

    if (coverImage != null) {
      files.add(MultipartBody(fieldKey: "coverImage", file: coverImage));
    }

    if (gallery != null) {
      for (final image in gallery) {
        files.add(MultipartBody(fieldKey: "gallery", file: image));
      }
    }

    return _apiClient.uploadMultipart(
      url: ApiUrls.updateBusiness(),

      method: "PATCH",

      fields: data.map((key, value) => MapEntry(key, value.toString())),

      files: files,
      showResponse: true,
    );
  }
}
