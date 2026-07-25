import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/custom_assets/assets.gen.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/customer/home/model/merchant_model.dart';
import 'package:som_spot/helper/launcher/launcher_helper.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../features/merchant/merchant_campaign_details/widgets/merchant_campaign_influencer_card.dart';
import 'widgets/app_rating_bottom_sheet.dart';
import 'widgets/influencer_request_bottom_sheet.dart';

Widget makeDismissable(BuildContext context, {required Widget child}) =>
    GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(onTap: () {}, child: child),
    );

void showYesNoModal(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmButtonText,
  required VoidCallback onConfirm,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return ConfirmationModalBottomSheet(
        title: title,
        message: message,
        confirmButtonText: confirmButtonText,
        onConfirm: onConfirm,
      );
    },
  );
}

//
void showRatingBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const RatingBottomSheet(),
  );
}

void showInfluencerRequestBottomSheet(
  BuildContext context, {
  required InfluencerModel influencer,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => InfluencerRequestBottomSheet(influencer: influencer),
  );
}

class ConfirmationModalBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonText;
  final VoidCallback onConfirm;

  const ConfirmationModalBottomSheet({
    super.key,
    required this.title,
    required this.message,
    required this.confirmButtonText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDarkMode
        ? AppColors.white
        : AppColors.blackMainTextColor;

    return makeDismissable(
      context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.40,
        minChildSize: 0.25,
        maxChildSize: 0.4,
        expand: false,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: Assets.icons.successfullIcon.svg()),
                  Gap(24.h),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22.sp,
                      color: primaryTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(12.h),
                  Text(
                    message,
                    style: TextStyle(
                      color: AppColors.grayTextSecondaryColor,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(36.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Back'.tr,
                          onTap: () => AppRouter.route.pop(),
                        ),
                      ),
                      Gap(16.w),
                      Expanded(
                        child: CustomButton(
                          text: confirmButtonText,
                          onTap: () {
                            onConfirm();
                            AppRouter.route.pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showDirectionsBottomSheet(
  BuildContext context, {
  required MerchantModel merchant,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DirectionsBottomSheet(merchant: merchant);
    },
  );
}

class DirectionsBottomSheet extends StatelessWidget {
  final MerchantModel merchant;

  const DirectionsBottomSheet({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDarkMode
        ? AppColors.white
        : AppColors.blackMainTextColor;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Gap(20.h),

          // Title & Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Get Directions",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.sp,
                  color: primaryTextColor,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Text(
            "Choose your navigation app",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.grayTextSecondaryColor,
            ),
          ),
          Gap(16.h),

          // Mock Map Card
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = 180.h;
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF0F172A,
                  ), // Slate 900 background for contrast
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Stack(
                  children: [
                    // Roads & Route
                    Positioned.fill(
                      child: CustomPaint(painter: MockMapPainter()),
                    ),
                    // Start Node
                    Positioned(
                      left: width * 0.15 - 10,
                      top: height * 0.75 - 10,
                      child: Container(
                        width: 20.r,
                        height: 20.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withValues(alpha: 0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // End Node (Pin)
                    Positioned(
                      left: width * 0.75 - 14,
                      top: height * 0.38 - 28,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 28,
                      ),
                    ),
                    // Bubble 1 (Fastest Route)
                    Positioned(
                      left: 12.w,
                      top: 12.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.navigation,
                              color: Colors.blue,
                              size: 14.sp,
                            ),
                            Gap(4.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1.2 km • 8 min",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Fastest route",
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bubble 2 (Merchant Title)
                    Positioned(
                      right: 12.w,
                      top: 12.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          merchant.title,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Gap(24.h),

          // Options (Google Maps & Apple Maps)
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    LauncherHelper.launchGoogleMaps(
                      "Maka Al Mukarama Road, Mogadishu",
                    );
                  },
                  icon: const Icon(Icons.map_outlined),
                  label: const Text("Google Maps"),
                ),
              ),
              Gap(12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    LauncherHelper.launchAppleMaps(
                      "Maka Al Mukarama Road, Mogadishu",
                    );
                  },
                  icon: const Icon(Icons.apple),
                  label: const Text("Apple Maps"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MockMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFF334155).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final routePaint = Paint()
      ..color =
          const Color(0xFF1D4ED8) // Deep blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Draw background decoration shapes (like the green park area on bottom right)
    final parkPaint = Paint()
      ..color = const Color(0xFF86A789).withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromLTWH(
        size.width * 0.65,
        size.height * 0.6,
        size.width * 0.3,
        size.height * 0.35,
      ),
      parkPaint,
    );

    // Draw some road paths
    final roadPath1 = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.5,
        size.width,
        size.height * 0.4,
      );

    final roadPath2 = Path()
      ..moveTo(size.width * 0.3, 0)
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.5,
        size.width * 0.3,
        size.height,
      )
      ..moveTo(size.width * 0.75, 0)
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.5,
        size.width * 0.75,
        size.height,
      );

    canvas.drawPath(roadPath1, roadPaint);
    canvas.drawPath(roadPath2, roadPaint);

    // Draw route path (blue line connecting start and end)
    final routePath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.75)
      ..cubicTo(
        size.width * 0.35,
        size.height * 0.7,
        size.width * 0.5,
        size.height * 0.45,
        size.width * 0.75,
        size.height * 0.38,
      );
    canvas.drawPath(routePath, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
