import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../controller/merchant_campaign_details_controller.dart';
import 'merchant_campaign_content_card.dart';

class MerchantCampaignContentTab
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignContentTab({super.key});

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

        builder: (_) {
          final contents = controller.contents;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            itemCount: contents.length,

            itemBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),

                child: MerchantCampaignContentCard(data: contents[index]),
              );
            },
          );
        },
      ),
    );
  }
}
