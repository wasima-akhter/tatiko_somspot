import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../controller/merchant_campaign_details_controller.dart';
import 'merchant_campaign_published_card.dart';

class MerchantCampaignPublishedTab
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignPublishedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.contentsPaginator.status.value,

        errorMessage: controller.contentsPaginator.errorMessage.value,

        onRetry: controller.refreshContents,

        isLoadingMore:
            controller.contentsPaginator.loadMoreStatus.value ==
            ApiStatus.loading,

        hasMore: controller.contentsPaginator.hasMore.value,

        noDataWidget: _noPublishedContentPlaceholder(context),

        builder: (_) {
          final contents = controller.contents;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            itemCount: contents.length,

            itemBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: MerchantCampaignPublishedCard(data: contents[index]),
              );
            },
          );
        },
      ),
    );
  }

  Widget _noPublishedContentPlaceholder(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76.w,
                height: 76.w,
                decoration: BoxDecoration(
                  color: AppColors.blueAccentColor.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.link_rounded,
                  size: 38.sp,
                  color: AppColors.blueAccentColor,
                ),
              ),

              SizedBox(height: 18.h),

              Text(
                AppStrings.noPublishedContentYet.tr,
                textAlign: TextAlign.center,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                AppStrings.noPublishedContentDescription.tr,
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(
                  color: AppColors.subtitleTextColor,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 18.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.refreshContents,
                  icon: Icon(Icons.refresh_rounded, size: 18.sp),
                  label: Text(AppStrings.retry.tr),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
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
