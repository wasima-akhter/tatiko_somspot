// -----------------------------------------------------------------------------
// 4. Expired Claims List Widget (`expired_claims_list_widget.dart`)
// -----------------------------------------------------------------------------
import 'package:som_spot/features/customer/claims/controller/claims_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import 'claim_item_card.dart';

class ExpiredClaimsListWidget extends GetView<ClaimsController> {
  const ExpiredClaimsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.expiredPaginator.status.value,
        errorMessage: controller.expiredPaginator.errorMessage.value,
        onRetry: () => controller.expiredPaginator.refresh(),
        isLoadingMore:
            controller.expiredPaginator.loadMoreStatus.value ==
            ApiStatus.loading,
        hasMore: controller.expiredPaginator.hasMore.value,
        builder: (_) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            controller: controller.listScrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: controller.expiredPaginator.items.length,
            separatorBuilder: (_, index) => Gap(12.h),
            itemBuilder: (context, index) {
              final claim = controller.expiredPaginator.items[index];
              return ClaimItemCard(claim: claim, isActive: false);
            },
          );
        },
      ),
    );
  }
}
