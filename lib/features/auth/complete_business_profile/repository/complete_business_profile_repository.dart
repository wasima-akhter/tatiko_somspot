import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:som_spot/utils/multipart/multipart_body.dart';

import '../../../../core/service/datasource/remote/api_client.dart';
import '../../../../utils/api_urls/api_urls.dart';
import '../service/complete_business_profile_request.dart';

class CompleteBusinessProfileRepository {
  final ApiClient _apiClient;

  CompleteBusinessProfileRepository(this._apiClient);

  Future<Response> createBusiness(CompleteBusinessProfileRequest request) {
    return _apiClient.uploadMultipart(
      url: ApiUrls.createBusiness(),
      method: "POST",

      fields: {
        "name": request.name,
        "category": request.category,
        "description": request.description,
        "phone": request.phone,
        "address": request.address,

        "lng": request.lng.toString(),
        "lat": request.lat.toString(),

        // backend expects array
        "openingHours": jsonEncode(request.openingHours),
      },

      files: [
        MultipartBody(fieldKey: "logo", file: request.logo),
        MultipartBody(fieldKey: "coverImage", file: request.coverImage),
      ],
    );
  }
}
