// -----------------------------------------------------------------------------
// 5. Claim Item Card (`claim_item_card.dart` or reusable inside active widget)
// -----------------------------------------------------------------------------
import 'package:som_spot/features/customer/claims/widgets/offer_claimed_dialog.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../shared/response/claims_model.dart';

class ClaimItemCard extends StatelessWidget {
  final ClaimWalletItemModel claim;
  final bool isActive;

  const ClaimItemCard({super.key, required this.claim, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.backgroundsLinesColor.withValues(alpha: 0.8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Opacity(
        opacity: isActive ? 1.0 : 0.65,
        child: Row(
          children: [
            // Business Image Left
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.backgroundsLinesColor,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11.r),
                child: CustomNetworkImage(imageUrl: claim.business?.logo ?? ""),
              ),
            ),
            Gap(12.w),

            // Claim Details Center
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (claim.business?.name ?? "").capitalizeWords(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall.copyWith(
                      color: AppColors.subtitleTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    (claim.offer?.title ?? "").capitalizeWords(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall.copyWith(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                  Gap(6.h),
                  Row(
                    children: [
                      Icon(
                        Iconsax.clock,
                        size: 12.sp,
                        color: isActive
                            ? Colors.red.shade400
                            : AppColors.hintTextColor,
                      ),
                      Gap(4.w),
                      Text(
                        _formatExpiryDate(claim.expiresAt, isActive),
                        style: context.titleSmall.copyWith(
                          color: isActive
                              ? Colors.red.shade400
                              : AppColors.hintTextColor,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(12.w),
            _ClaimActionButton(claim: claim, isActive: isActive),
          ],
        ),
      ),
    );
  }

  String _formatExpiryDate(DateTime? expiresAt, bool isActive) {
    if (expiresAt == null) {
      return 'No expiration date'; // Fallback text when expiresAt is null
    }

    final formattedDate = expiresAt.toLocal().toString().split(' ')[0];
    return "${isActive ? 'Expires' : 'Expired'}: $formattedDate";
  }
}

class _ClaimActionButton extends StatelessWidget {
  final ClaimWalletItemModel claim;
  final bool isActive;

  const _ClaimActionButton({required this.claim, required this.isActive});

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => OfferClaimedDialog(
              claimCode: claim.code,
              businessName: claim.business?.name ?? "",
              offerTitle: claim.offer?.title ?? "",
            ),
          );
        },
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: 70.w,
          height: 32.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            AppStrings.view.tr,
            style: context.titleSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 70.w,
      height: 32.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.backgroundsLinesColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        AppStrings.expired.tr,
        style: context.titleSmall.copyWith(
          color: AppColors.hintTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
