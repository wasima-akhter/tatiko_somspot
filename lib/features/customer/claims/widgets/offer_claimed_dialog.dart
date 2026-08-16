import 'package:qr_flutter/qr_flutter.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../../helper/qr_code/qr_code_helper.dart';

class OfferClaimedDialog extends StatefulWidget {
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
  State<OfferClaimedDialog> createState() => _OfferClaimedDialogState();
}

class _OfferClaimedDialogState extends State<OfferClaimedDialog> {
  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
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
                "${AppStrings.offerClaimed.tr}!",
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: AppColors.darkTextColor,
                ),
              ),
              Gap(6.h),

              // Subtitle / Business details
              Text(
                widget.offerTitle.capitalizeWords(),
                textAlign: TextAlign.center,
                style: context.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(2.h),
              Text(
                widget.businessName.capitalizeWords(),
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

              // QR Code Container
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.backgroundsLinesColor.withValues(
                      alpha: 0.8,
                    ),
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
                child: QrImageView(
                  data: widget.claimCode,
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
              ),
              Gap(16.h),

              // Claim Code Box Label
              Text(
                AppStrings.claimCode.tr,
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
                  widget.claimCode,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                    letterSpacing: 1.5.w,
                  ),
                ),
              ),
              Gap(16.h),

              // QR Actions (Copy & Download with Loading Handler)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isDownloading
                          ? null
                          : () {
                              QrCodeHelper.copy(context, widget.claimCode);
                            },
                      icon: Icon(Icons.copy_rounded, size: 17.sp),
                      label: const Text('Copy'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: BorderSide(
                          color: AppColors.primaryColor,
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
                      onPressed: _isDownloading
                          ? null
                          : () async {
                              setState(() => _isDownloading = true);
                              try {
                                await QrCodeHelper.download(
                                  context,
                                  widget.claimCode,
                                  fileName: 'claim_${widget.claimCode}',
                                );
                              } finally {
                                if (mounted) {
                                  setState(() => _isDownloading = false);
                                }
                              }
                            },
                      icon: _isDownloading
                          ? SizedBox(
                              width: 17.sp,
                              height: 17.sp,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Icon(Icons.download_rounded, size: 17.sp),
                      label: Text(
                        _isDownloading
                            ? AppStrings.saving.tr
                            : AppStrings.download.tr,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
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
              Gap(16.h),

              // Instruction Text
              Text(
                AppStrings.presentQrCodeToMerchant.tr,
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(
                  color: AppColors.subtitleTextColor,
                  fontSize: 12.sp,
                  height: 1.4,
                ),
              ),
              Gap(20.h),

              // Done Button
              SizedBox(
                width: double.infinity,
                height: 42.h,
                child: OutlinedButton(
                  onPressed: _isDownloading
                      ? null
                      : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: BorderSide(color: AppColors.primaryColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.done.tr,
                    style: context.bodyLarge.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
