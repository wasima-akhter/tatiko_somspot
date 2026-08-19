import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../../offers/shared/response/offers_response.dart';

class MerchantOfferImage extends StatelessWidget {
  final OfferModel deal;

  const MerchantOfferImage({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Stack(
        children: [
          CustomNetworkImage(
            imageUrl: deal.business?.logo ?? '',
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColors.orangeSecondaryAccentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
              ),
              child: Text(
                deal.discountLabel,
                style: context.bodySmall.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
