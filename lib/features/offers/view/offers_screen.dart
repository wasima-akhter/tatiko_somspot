import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/offers/widgets/offer_list_card.dart';
import 'package:som_spot/features/offers/widgets/offers_header.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/offer_controller.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final controller = OffersController.to;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadOffers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,

      body: Column(
        children: [
          const OffersHeader(),

          Expanded(
            child: Obx(
              () => ApiStatusBuilder(
                status: controller.paginator.status.value,
                errorMessage: controller.paginator.errorMessage.value,
                onRetry: controller.loadOffers,

                isLoadingMore:
                    controller.paginator.loadMoreStatus.value ==
                    ApiStatus.loading,
                hasMore: controller.paginator.hasMore.value,

                builder: (_) {
                  return CustomRefreshIndicator(
                    onRefresh: controller.refreshOffers,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: controller.listScrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      itemCount: controller.paginator.items.length,
                      itemBuilder: (_, index) {
                        final offer = controller.paginator.items[index];

                        return OfferListCard(
                          badgeText: offer.discountLabel,
                          imagePath: offer.business?.logo ?? "",
                          restaurantName: offer.business?.name ?? "",
                          title: offer.title,
                          timeText: _getRemainingTime(offer.endAt),
                          isEndingSoon:
                              offer.endAt.difference(DateTime.now()).inDays < 3,
                          actionText: "${offer.totalClaims} claims",
                          actionType: 0,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getRemainingTime(DateTime endAt) {
    final duration = endAt.difference(DateTime.now());

    if (duration.inDays > 0) {
      return "${duration.inDays} days";
    }

    if (duration.inHours > 0) {
      return "${duration.inHours} hours";
    }

    return "${duration.inMinutes} minutes";
  }
}
