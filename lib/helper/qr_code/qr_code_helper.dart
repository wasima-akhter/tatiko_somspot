import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:som_spot/helper/snackbar/api_snackbar.dart';
import 'package:som_spot/share/export/screen_export.dart';

class QrCodeHelper {
  QrCodeHelper._();

  // ============================================================
  // Copy QR / Claim Code
  // ============================================================

  static Future<void> copy(BuildContext context, String data) async {
    if (data.trim().isEmpty) {
      return;
    }

    await Clipboard.setData(ClipboardData(text: data.trim()));

    if (!context.mounted) return;

    ApiSnackbar.show(AppStrings.claimCodeCopied.tr, type: SnackbarType.success);
  }

  // ============================================================
  // Generate QR PNG
  // ============================================================

  static Future<Uint8List?> generateBytes(
    String data, {
    double size = 800,
  }) async {
    if (data.trim().isEmpty) {
      return null;
    }

    final painter = QrPainter(
      data: data.trim(),
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Colors.black,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: Colors.black,
      ),
    );

    final byteData = await painter.toImageData(
      size,
      format: ImageByteFormat.png,
    );

    return byteData?.buffer.asUint8List();
  }

  // ============================================================
  // Download / Save QR to Gallery
  // ============================================================

  static Future<bool> download(
    BuildContext context,
    String data, {
    String fileName = 'claim_qr',
  }) async {
    try {
      final bytes = await generateBytes(data);

      if (bytes == null) {
        return false;
      }

      final hasAccess = await Gal.hasAccess();

      if (!hasAccess) {
        final granted = await Gal.requestAccess();

        if (!granted) {
          if (context.mounted) {
            ApiSnackbar.show(
              AppStrings.galleryPermissionRequired.tr,
              type: SnackbarType.success,
            );
          }

          return false;
        }
      }

      await Gal.putImageBytes(bytes, name: fileName);

      if (context.mounted) {
        ApiSnackbar.show(
          AppStrings.qrCodeSavedToGallery.tr,
          type: SnackbarType.success,
        );
      }

      return true;
    } on GalException catch (e) {
      print('QR Download Error => ${e.type.message}');

      if (context.mounted) {
        // Keep plugin-specific error if available.
        print(e.type.message);
      }

      return false;
    } catch (e, s) {
      print('QR Download Error => $e');
      debugPrintStack(stackTrace: s);

      if (context.mounted) {
        ApiSnackbar.show(AppStrings.failedToSaveQrCode.tr);
      }

      return false;
    }
  }

  // ============================================================
  // Snackbar
  // ============================================================

  static void _showMessage(BuildContext context, String message) {}
}
