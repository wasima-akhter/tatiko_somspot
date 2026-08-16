import '../../../../share/export/screen_export.dart';
import '../../shared/response/offers_response.dart';
import '../controller/offer_detail_controller.dart';

class OfferDetailsActionButton extends StatelessWidget {
  final OfferModel offer;

  const OfferDetailsActionButton({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              final updated = await AppRouter.route.pushNamed(
                RoutePath.editOfferScreen,
                extra: offer,
              );

              if (updated == true) {
                await OfferDetailController.to.getOfferDetails();
              }
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,

              elevation: 0,

              padding: EdgeInsets.symmetric(vertical: 14.h),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),

            child: Text(
              AppStrings.editOffer.tr,

              style: context.titleSmall.copyWith(
                color: AppColors.white,

                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
        // Expanded(
                //   child: OutlinedButton(
                //     onPressed: () {},
                //     style: OutlinedButton.styleFrom(
                //       side: const BorderSide(color: AppColors.primaryColor),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.r),
                //       ),
                //       padding: EdgeInsets.symmetric(vertical: 14.h),
                //     ),
                //     child: Text(
                //       AppStrings.pause.tr,
                //       style: context.titleSmall.copyWith(
                //         color: AppColors.primaryColor,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
                // ),
                // Gap(16.w),
