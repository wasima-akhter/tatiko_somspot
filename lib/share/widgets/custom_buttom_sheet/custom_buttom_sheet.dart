import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:som_spot/core/custom_assets/assets.gen.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/helper/launcher/launcher_helper.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../features/customer/customer_business_details/shared/model/customer_buiness_details_model.dart';
import '../../../utils/config/app_config.dart';
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
  required String creatorId,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => InfluencerRequestBottomSheet(creatorId: creatorId),
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
  required BusinessDetailsModel business,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DirectionsBottomSheet(business: business);
    },
  );
}

class DirectionsBottomSheet extends StatelessWidget {
  final BusinessDetailsModel business;

  const DirectionsBottomSheet({super.key, required this.business});

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
      child: SafeArea(
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

            // Real Map Card
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
                        child: SizedBox(
                          height: 180.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: LatLng(23.76355, 90.4004),
                                initialZoom: 12,
                                interactionOptions: const InteractionOptions(
                                  flags: InteractiveFlag.none,
                                ),
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: AppConfig.mapTilerUrlTemplate,

                                  userAgentPackageName:
                                      AppConfig.userAgentPackageName,
                                  //    urlTemplate:  'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=${AppConfig.mapTilerApiKey}',
                                  // userAgentPackageName:
                                  //     'com.yourcompany.yourapp',
                                ),

                                // Route
                                PolylineLayer(
                                  polylines: [
                                    Polyline(
                                      points: [
                                        const LatLng(23.7465, 90.3760),
                                        const LatLng(23.7550, 90.3850),
                                        const LatLng(23.7650, 90.4000),
                                        const LatLng(23.7806, 90.4248),
                                      ],
                                      color: Colors.blue,
                                      strokeWidth: 5,
                                    ),
                                  ],
                                ),

                                // Start + destination markers
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: const LatLng(23.7465, 90.3760),
                                      width: 40,
                                      height: 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue.withValues(
                                                alpha: 0.35,
                                              ),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.navigation,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),

                                    Marker(
                                      point: const LatLng(23.7806, 90.4248),
                                      width: 45,
                                      height: 45,
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //  CustomPaint(painter: MockMapPainter()),
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
                            business.name,
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
                      LauncherHelper.launchDirectionsInGoogleMaps(
                        startLatitude: 23.7465,
                        startLongitude: 90.3760,
                        destinationLatitude: 23.7806,
                        destinationLongitude: 90.4248,
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
                      LauncherHelper.launchDirectionsInAppleMaps(
                        startLatitude: 23.7465,
                        startLongitude: 90.3760,
                        destinationLatitude: 23.7806,
                        destinationLongitude: 90.4248,
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
      ),
    );
  }
}
