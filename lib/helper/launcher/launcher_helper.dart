import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_strings/app_strings.dart';

class LauncherHelper {
  /// Launches the phone dialer with the specified [phoneNumber].
  static Future<void> launchPhoneDialer(
    BuildContext context,
    String phoneNumber,
  ) async {
    final Uri dialUri = Uri(scheme: 'tel', path: phoneNumber);

    print('"phoneNumber  : $phoneNumber');

    try {
      if (await canLaunchUrl(dialUri)) {
        await launchUrl(dialUri);
      } else {
        if (context.mounted) {
          AppToast.info(
            context: context,
            message: AppStrings.dialerNotSupported.tr,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        AppToast.info(
          context: context,
          message: AppStrings.couldNotLaunchDialer.tr,
        );
        print("Could not launch dialer: $e");
      }
    }
  }

  /// Launches Google Maps with a query.
  static Future<void> launchGoogleMaps(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$encodedQuery",
    );
    try {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      print("Could not launch Google Maps: $e");
    }
  }

  static Future<void> launchDirectionsInGoogleMaps({
    required double destinationLatitude,
    required double destinationLongitude,
    double? startLatitude,
    double? startLongitude,
  }) async {
    final destination = '$destinationLatitude,$destinationLongitude';

    final queryParams = <String, String>{
      'api': '1',
      'destination': destination,
      'travelmode': 'driving',
      'dir_action': 'navigate',
    };

    // Optionally specify the starting location.
    if (startLatitude != null && startLongitude != null) {
      queryParams['origin'] = '$startLatitude,$startLongitude';
    }

    final url = Uri.https('www.google.com', '/maps/dir/', queryParams);

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch Google Maps: $e');
    }
  }

  static Future<void> launchDirectionsInAppleMaps({
    String? destination,
    double? startLatitude,
    double? startLongitude,
    double? destinationLatitude,
    double? destinationLongitude,
  }) async {
    final params = <String, String>{'dirflg': 'd'};

    if (startLatitude != null && startLongitude != null) {
      params['saddr'] = '$startLatitude,$startLongitude';
    }

    if (destinationLatitude != null && destinationLongitude != null) {
      params['daddr'] = '$destinationLatitude,$destinationLongitude';
    } else if (destination != null && destination.isNotEmpty) {
      params['daddr'] = destination;
    }

    final url = Uri(
      scheme: 'https',
      host: 'maps.apple.com',
      queryParameters: params,
    );

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch Apple Maps: $e');
    }
  }

  /// Launches Apple Maps with a query.
  static Future<void> launchAppleMaps(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final appleMapsUrl = Uri.parse("https://maps.apple.com/?q=$encodedQuery");
    try {
      await launchUrl(appleMapsUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      print("Could not launch Apple Maps: $e");
    }
  }

  /// Shares merchant details using standard device sharing sheets.
  static Future<void> shareMerchant(
    BuildContext context, {
    required String title,
    required String category,
  }) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          title: AppStrings.checkOutMerchantOnSomSpot.trParams({
            'title': title,
            'category': category,
          }),
          subject: AppStrings.somspotMerchant.trParams({'title': title}),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        AppToast.info(
          context: context,
          message: AppStrings.couldNotShareMerchantDetails.tr,
        );

        print("Could not share merchant details: $e");
      }
    }
  }

  /// Launches WhatsApp with the specified [phoneNumber].
  static Future<void> launchWhatsApp(
    BuildContext context,
    String phoneNumber,
  ) async {
    // Clean the phone number of all non-numeric characters
    final cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    final whatsAppUrl = Uri.parse("https://wa.me/$cleanPhoneNumber");
    try {
      // Launch directly without canLaunchUrl check because of package visibility restrictions on iOS/Android.
      final launched = await launchUrl(
        whatsAppUrl,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        if (context.mounted) {
          AppToast.info(
            context: context,
            message: AppStrings.whatsappCannotBeOpened.tr,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        AppToast.info(
          context: context,
          message: AppStrings.couldNotLaunchWhatsapp.tr,
        );
        print("Could not launch WhatsApp: $e");
      }
    }
  }
}
