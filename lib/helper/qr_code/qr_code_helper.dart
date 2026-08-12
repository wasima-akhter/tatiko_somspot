import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Claim code copied'),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
            _showMessage(context, 'Gallery permission is required');
          }

          return false;
        }
      }

      await Gal.putImageBytes(bytes, name: fileName);

      if (context.mounted) {
        _showMessage(context, 'QR code saved to gallery');
      }

      return true;
    } on GalException catch (e) {
      debugPrint('QR Download Error => ${e.type.message}');

      if (context.mounted) {
        _showMessage(context, e.type.message);
      }

      return false;
    } catch (e, s) {
      debugPrint('QR Download Error => $e');
      debugPrintStack(stackTrace: s);

      if (context.mounted) {
        _showMessage(context, 'Failed to save QR code');
      }

      return false;
    }
  }

  // ============================================================
  // Snackbar
  // ============================================================

  static void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}
