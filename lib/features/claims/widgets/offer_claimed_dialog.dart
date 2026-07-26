import 'package:som_spot/share/controller/screen_export.dart';

class OfferClaimedDialog extends StatelessWidget {
  final String claimCode;
  final String businessName;
  final String offerTitle;

  const OfferClaimedDialog({
    super.key,
    required this.claimCode,
    required this.businessName,
    required this.offerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon Circle
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.green.shade600,
                size: 32.sp,
              ),
            ),
            Gap(16.h),

            // Title
            Text(
              "Offer Claimed!",
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: AppColors.darkTextColor,
              ),
            ),
            Gap(6.h),

            // Subtitle / Business details
            Text(
              offerTitle,
              textAlign: TextAlign.center,
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.primaryColor,
              ),
            ),
            Text(
              businessName,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                color: AppColors.subtitleTextColor,
                fontSize: 12.sp,
              ),
            ),
            Gap(20.h),

            // Dotted Separator
            Row(
              children: List.generate(
                20,
                (index) => Expanded(
                  child: Container(
                    color: index.isEven
                        ? AppColors.backgroundsLinesColor
                        : Colors.transparent,
                    height: 1.5.h,
                  ),
                ),
              ),
            ),
            Gap(20.h),

            // QR Code Container (Realistic Premium Custom Vector QR)
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.backgroundsLinesColor.withValues(alpha: 0.8),
                  width: 1.5.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: SizedBox(
                width: 140.w,
                height: 140.h,
                child: CustomPaint(painter: _QrCodePainter()),
              ),
            ),
            Gap(16.h),

            // Claim Code Box
            Text(
              "Claim Code",
              style: context.bodySmall.copyWith(
                color: AppColors.hintTextColor,
                fontSize: 11.sp,
              ),
            ),
            Gap(4.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Text(
                claimCode,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: AppColors.primaryColor,
                  letterSpacing: 1.5.w,
                ),
              ),
            ),
            Gap(16.h),

            // Instruction Text
            Text(
              "Present this QR code to the merchant to redeem your offer.",
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                color: AppColors.subtitleTextColor,
                fontSize: 12.sp,
                height: 1.4,
              ),
            ),
            Gap(24.h),

            // Done Button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Done",
                  style: context.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter to draw a high-fidelity vector QR Code placeholder
class _QrCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.darkTextColor
      ..style = PaintingStyle.fill;

    // Draw the three standard QR positioning blocks (corners)
    _drawPositioningBlock(canvas, Offset.zero, 36.w, paint);
    _drawPositioningBlock(canvas, Offset(size.width - 36.w, 0), 36.w, paint);
    _drawPositioningBlock(canvas, Offset(0, size.height - 36.w), 36.w, paint);

    // Draw some dynamic random QR data pixel patterns inside the central/bottom areas
    final pixelSize = 5.w;
    final startX = 42.w;
    final startY = 42.w;

    // Fixed patterns for data simulation to keep it deterministic
    final patterns = [
      [1, 0, 1, 1, 0, 1, 0],
      [0, 1, 0, 0, 1, 1, 1],
      [1, 1, 0, 1, 0, 0, 1],
      [0, 0, 1, 1, 0, 1, 0],
      [1, 0, 1, 0, 1, 1, 0],
      [0, 1, 0, 1, 0, 0, 1],
      [1, 1, 1, 0, 1, 1, 0],
    ];

    for (int r = 0; r < patterns.length; r++) {
      for (int c = 0; c < patterns[r].length; c++) {
        if (patterns[r][c] == 1) {
          final x = startX + (c * pixelSize * 1.5);
          final y = startY + (r * pixelSize * 1.5);
          if (x < size.width && y < size.height) {
            canvas.drawRect(Rect.fromLTWH(x, y, pixelSize, pixelSize), paint);
          }
        }
      }
    }

    // Add extra decorative outer small data blocks
    canvas.drawRect(
      Rect.fromLTWH(
        size.width - 18.w,
        size.height - 18.h,
        pixelSize * 2,
        pixelSize * 2,
      ),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width - 28.w,
        size.height - 12.h,
        pixelSize,
        pixelSize,
      ),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width - 12.w,
        size.height - 28.h,
        pixelSize,
        pixelSize,
      ),
      paint,
    );
  }

  void _drawPositioningBlock(
    Canvas canvas,
    Offset offset,
    double size,
    Paint paint,
  ) {
    // Outer Border Box
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.w;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(offset.dx + 2.w, offset.dy + 2.h, size - 4.w, size - 4.h),
        Radius.circular(6.r),
      ),
      paint,
    );

    // Inner Solid Square
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          offset.dx + 9.w,
          offset.dy + 9.h,
          size - 18.w,
          size - 18.h,
        ),
        Radius.circular(2.r),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
