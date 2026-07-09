import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../share/widgets/network_image/custom_network_image.dart';

class CampaignBanner extends StatelessWidget {
  const CampaignBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      child: SizedBox(
        height: 180.h,
        width: double.infinity,
        child: Stack(
          children: [
            CustomNetworkImage(
              imageUrl:
                  "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withValues(alpha: .65),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              left: 14.w,
              bottom: 14.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mogadishu Pizza",
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    "Buy 1 Get 1 Free Promo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
