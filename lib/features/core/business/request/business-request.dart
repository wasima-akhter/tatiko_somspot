import 'dart:convert';
import 'dart:io';

import '../../../../utils/multipart/multipart_body.dart';

class EditBusinessRequest {
  final String businessId;

  final String name;

  final String category;

  final String description;

  final String phone;

  final String whatsapp;

  final String address;

  final double lat;

  final double lng;

  final String timezone;

  final List<BusinessOpeningHourRequest> openingHours;

  final File? logo;

  final File? coverImage;

  final List<File>? gallery;

  EditBusinessRequest({
    required this.businessId,

    required this.name,

    required this.category,

    required this.description,

    required this.phone,

    required this.whatsapp,

    required this.address,

    required this.lat,

    required this.lng,

    required this.timezone,

    required this.openingHours,

    this.logo,

    this.coverImage,

    this.gallery,
  });

  Map<String, String> fields() {
    return {
      "businessId": businessId,

      "name": name,

      "category": category,

      "description": description,

      "phone": phone,

      "whatsapp": whatsapp,

      "address": address,

      "lat": lat.toString(),

      "lng": lng.toString(),

      "timezone": timezone,

      // Important:
      // Multipart sends fields as String.
      // Backend expects JSON array.
      "openingHours": jsonEncode(openingHours.map((e) => e.toJson()).toList()),
    };
  }

  List<MultipartBody> files() {
    final result = <MultipartBody>[];

    if (logo != null) {
      result.add(MultipartBody(fieldKey: "logo", file: logo!));
    }

    if (coverImage != null) {
      result.add(MultipartBody(fieldKey: "coverImage", file: coverImage!));
    }

    if (gallery != null) {
      for (final image in gallery!) {
        result.add(MultipartBody(fieldKey: "gallery", file: image));
      }
    }

    return result;
  }
}

class BusinessOpeningHourRequest {
  final String day;

  final String open;

  final String close;

  final bool closed;

  BusinessOpeningHourRequest({
    required this.day,
    required this.open,
    required this.close,
    required this.closed,
  });

  Map<String, dynamic> toJson() {
    return {"day": day, "open": open, "close": close, "closed": closed};
  }
}
