import 'package:qr_flutter/qr_flutter.dart';

import '../../../../helper/qr_code/qr_code_helper.dart';
import '../../../../share/controller/screen_export.dart';
import '../controller/customer_offer_claim_controller.dart';

class OfferClaimScreen extends GetView<OfferClaimController> {
  const OfferClaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: "QR Code",
      onPressed: () => AppRouter.route.pop(),
      body: SafeArea(
        child: Column(
          children: [
            // ============================================================
            // Content
            // ============================================================
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Gap(24.h),

                    // ======================================================
                    // Success Icon
                    // ======================================================
                    Container(
                      width: 84.w,
                      height: 84.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withValues(alpha: 0.3),
                            blurRadius: 30.r,
                            offset: Offset(0, 8.h),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.success,
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: AppColors.success,
                            size: 22.sp,
                          ),
                        ),
                      ),
                    ),

                    Gap(20.h),

                    // ======================================================
                    // Title
                    // ======================================================
                    Text(
                      AppStrings.offerClaimedTitle.tr,
                      textAlign: TextAlign.center,
                      style: context.headlineLarge.copyWith(
                        color: const Color(0xFF42A5FF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Gap(8.h),

                    // ======================================================
                    // Subtitle
                    // ======================================================
                    Text(
                      'Show this code to the merchant to\nredeem your discount.',
                      textAlign: TextAlign.center,
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF91A7C0),
                        height: 1.5,
                      ),
                    ),

                    Gap(24.h),

                    // ======================================================
                    // Claim Card
                    // ======================================================
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(12.w, 28.h, 12.w, 28.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF6D8BA8,
                            ).withValues(alpha: 0.12),
                            blurRadius: 20.r,
                            offset: Offset(0, 8.h),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // ==================================================
                          // Claim Code Label
                          // ==================================================
                          Text(
                            'Your Claim Code',
                            style: context.bodyMedium.copyWith(
                              color: const Color(0xFF71839C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Gap(8.h),

                          // ==================================================
                          // Claim Code
                          // ==================================================
                          Text(
                            controller.claimCode,
                            textAlign: TextAlign.center,
                            style: context.headlineLarge.copyWith(
                              color: const Color(0xFF101828),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 3.w,
                            ),
                          ),

                          Gap(16.h),

                          // ==================================================
                          // QR Code
                          // ==================================================
                          QrImageView(
                            data: controller.claimCode,
                            version: QrVersions.auto,
                            size: 130.w,
                            backgroundColor: Colors.white,
                            eyeStyle: const QrEyeStyle(
                              eyeShape: QrEyeShape.square,
                              color: Colors.black,
                            ),
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: Colors.black,
                            ),
                          ),

                          Gap(20.h),

                          // ==================================================
                          // QR Actions
                          // ==================================================
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    QrCodeHelper.copy(
                                      context,
                                      controller.claimCode,
                                    );
                                  },
                                  icon: Icon(Icons.copy_rounded, size: 17.sp),
                                  label: const Text('Copy'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF42A5FF),
                                    side: const BorderSide(
                                      color: Color(0xFF42A5FF),
                                      width: 1.2,
                                    ),
                                    minimumSize: Size(double.infinity, 42.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                ),
                              ),

                              Gap(12.w),

                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    await QrCodeHelper.download(
                                      context,
                                      controller.claimCode,
                                      fileName: 'claim_${controller.claimCode}',
                                    );
                                  },
                                  icon: Icon(
                                    Icons.download_rounded,
                                    size: 17.sp,
                                  ),
                                  label: const Text('Download'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF42A5FF),
                                    foregroundColor: Colors.white,
                                    minimumSize: Size(double.infinity, 42.h),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Gap(20.h),

                          // ==================================================
                          // Done Button
                          // ==================================================

                          // ==================================================
                          // Done Button
                          // ==================================================
                          SizedBox(
                            width: double.infinity,
                            height: 42.h,
                            child: OutlinedButton(
                              onPressed: controller.onDone,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF42A5FF),
                                side: const BorderSide(
                                  color: Color(0xFF42A5FF),
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'Done',
                                style: context.bodyLarge.copyWith(
                                  color: const Color(0xFF42A5FF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Gap(32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
