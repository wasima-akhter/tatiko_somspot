import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../controller/customer_business_details_controller.dart';
import '../tab_modulars/reviews_tab_content/merchant_empty_reviews.dart';
import '../tab_modulars/reviews_tab_content/merchant_rating_summary.dart';
import '../tab_modulars/reviews_tab_content/merchant_review_card.dart';
import '../tab_modulars/reviews_tab_content/merchant_reviews_skeleton.dart';

class MerchantReviewsTab extends StatefulWidget {
  const MerchantReviewsTab({super.key});

  @override
  State<MerchantReviewsTab> createState() => MerchantReviewsTabState();
}

class MerchantReviewsTabState extends State<MerchantReviewsTab> {
  final controller = CustomerBusinessDetailsController.to;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          child: MerchantRatingSummary(),
        ),
        Obx(
          () => ApiStatusBuilder(
            status: controller.reviewsPaginator.status.value,
            errorMessage: controller.reviewsPaginator.errorMessage.value,
            onRetry: controller.refreshBusinessReviews,
            loadingWidget: const MerchantReviewsSkeleton(),
            isLoadingMore:
                controller.reviewsPaginator.loadMoreStatus.value ==
                ApiStatus.loading,
            hasMore: controller.reviewsPaginator.hasMore.value,
            builder: (_) {
              final reviews = controller.reviews;

              debugPrint('reviews length: ${reviews.length}');

              return CustomRefreshIndicator(
                onRefresh: controller.refreshBusinessReviews,
                child: SingleChildScrollView(
                  controller: controller.reviewListScrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 64.h),
                  child: Container(
                    color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(12.h),

                        if (reviews.isEmpty)
                          MerchantEmptyReviews()
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: reviews.length,
                            separatorBuilder: (_, index) => Gap(16.h),
                            itemBuilder: (context, index) {
                              return MerchantReviewCard(review: reviews[index]);
                            },
                          ),

                        Obx(() {
                          final loading =
                              controller
                                  .reviewsPaginator
                                  .loadMoreStatus
                                  .value ==
                              ApiStatus.loading;

                          if (!loading) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Center(
                              child: SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          );
                        }),

                        Gap(64.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
