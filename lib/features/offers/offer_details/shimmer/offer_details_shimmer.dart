import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../../../share/export/screen_export.dart';
import 'offer_details_action_shimmer.dart';
import 'offer_details_primary_shimmer.dart';
import 'offer_details_terms_shimmer.dart';

class OfferDetailsShimmer extends StatelessWidget {
  const OfferDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),

      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),

      child: Column(
        children: [
          const OfferDetailsPrimaryShimmer(),

          Gap(16.h),

          const OfferDetailsTermsShimmer(),

          Gap(32.h),

          if (CommonController.to.isMerchandiser)
            const OfferDetailsActionShimmer(),

          Gap(40.h),
        ],
      ),
    );
  }
}
