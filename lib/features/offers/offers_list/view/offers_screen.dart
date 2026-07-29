import 'package:intl/intl.dart';
import 'package:som_spot/features/offers/offers_list/widgets/offer_list_card.dart';
import 'package:som_spot/features/offers/offers_list/widgets/offers_header.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../shared/helper/offer_helper.dart';
import '../../shared/response/offers_response.dart';
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
      backgroundColor: AppColors.backgroundColorNew,

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

                        debugPrint('offer id----> ${offer.id}');

                        final offerStatus = _getOfferDisplayData(offer);

                        return OfferListCard(
                          offer: offer,
                          offerId: offer.id,
                          badgeText: offer.discountLabel,
                          imagePath: offer.business?.logo ?? "",
                          restaurantName: offer.business?.name ?? "",
                          title: offer.title,
                          timeText: offerStatus.timeText,
                          isEndingSoon:
                              offer.endAt.difference(DateTime.now()).inDays < 3,

                          actionText: offerStatus.actionText,
                          actionType: offerStatus.actionType,
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

  OfferDisplayData _getOfferDisplayData(OfferModel offer) {
    debugPrint("STATUS => ${offer.status}");
    debugPrint("START => ${offer.startAt}");
    debugPrint("END => ${offer.endAt}");

    final now = DateTime.now();

    debugPrint("NOW => $now");

    if (offer.status.toLowerCase() == "expired" || offer.endAt.isBefore(now)) {
      return OfferDisplayData(
        timeText: "Ended ${_formatDate(offer.endAt)}",
        isEndingSoon: false,
        actionText: "${offer.totalClaims} claims",
        actionType: OfferActionType.claims,
      );
    }

    switch (offer.status.toLowerCase()) {
      case "active":
        return OfferDisplayData(
          timeText: _getRemainingTime(offer.endAt),
          isEndingSoon: offer.endAt.difference(DateTime.now()).inDays < 3,
          actionText: "${offer.totalClaims} claims",
          actionType: OfferActionType.claims,
        );

      case "scheduled":
        return OfferDisplayData(
          timeText: _getStartsInTime(offer.startAt),
          isEndingSoon: false,
          actionText: "Edit",
          actionType: OfferActionType.edit,
        );

      case "expired":
        return OfferDisplayData(
          timeText: "Ended ${_formatDate(offer.endAt)}",
          isEndingSoon: false,
          actionText: "${offer.totalClaims} claims",
          actionType: OfferActionType.claims,
        );

      default:
        return OfferDisplayData(
          timeText: "",
          isEndingSoon: false,
          actionText: "${offer.totalClaims} claims",
          actionType: OfferActionType.claims,
        );
    }
  }

  String _getStartsInTime(DateTime startAt) {
    final now = DateTime.now().toUtc();
    final start = startAt.toUtc();

    final duration = start.difference(now);

    if (duration.inDays > 0) {
      return "Starts in ${duration.inDays} days";
    }

    if (duration.inHours > 0) {
      return "Starts in ${duration.inHours} hours";
    }

    return "Starts in ${duration.inMinutes} minutes";
  }

  String _formatDate(DateTime date) {
    return DateFormat("MMM dd, yyyy").format(date);
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
