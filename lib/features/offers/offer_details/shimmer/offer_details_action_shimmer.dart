import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../share/export/screen_export.dart';

class OfferDetailsActionShimmer extends StatelessWidget {
  const OfferDetailsActionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoShimmerAnimate(
      isLoading: true,
      baseColor: AppColors.shimmerBaseColor,

      child: Container(
        width: double.infinity,

        height: 48.h,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
