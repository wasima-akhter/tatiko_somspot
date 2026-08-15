// -----------------------------------------------------------------------------
// 3. Active Claims List Widget (`active_claims_list_widget.dart`)
// -----------------------------------------------------------------------------
import 'package:som_spot/features/customer/claims/controller/claims_controller.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import 'claim_item_card.dart';

class ActiveClaimsListWidget extends GetView<ClaimsController> {
  const ActiveClaimsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.activePaginator.status.value,
        errorMessage: controller.activePaginator.errorMessage.value,
        onRetry: () => controller.activePaginator.refresh(),
        isLoadingMore:
            controller.activePaginator.loadMoreStatus.value ==
            ApiStatus.loading,
        hasMore: controller.activePaginator.hasMore.value,
        builder: (_) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: controller.activePaginator.items.length,
            separatorBuilder: (_, index) => Gap(10.h),
            itemBuilder: (context, index) {
              final claim = controller.activePaginator.items[index];
              return ClaimItemCard(claim: claim, isActive: true);
            },
          );
        },
      ),
    );
  }
}
