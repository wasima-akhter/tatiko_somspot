import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';

import '../../../../share/export/service_export.dart';
import '../../../../share/widgets/paginator/paginator.dart';
import '../../shared/helper/offer_helper.dart';
import '../../shared/response/offers_response.dart';
import '../../shared/service/offers_service.dart';

class OffersController extends GetxController {
  final OfferService _service;

  OffersController(this._service);

  static OffersController get to => Get.find();

  final selectedStatus = OfferStatus.active.obs;

  final tabScrollController = ScrollController();
  final listScrollController = ScrollController();

  final showLeft = false.obs;
  final showRight = true.obs;

  final statusCounts = <OfferStatus, int>{}.obs;

  ///

  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath.value = image.path;
      }
    } catch (e) {
      AppToast.error(message: 'Failed to pick image');
    }
  }

  void clearImage() {
    imagePath.value = '';
  }

  late final Paginator<OfferModel> paginator;

  @override
  void onInit() {
    super.onInit();

    paginator = Paginator(
      fetchPage: (page, limit) async {
        final response = await _service.getOffers(
          page: page,
          limit: limit,
          status: selectedStatus.value.value,
        );

        statusCounts[selectedStatus.value] =
            response.requireData.meta?.total ?? 0;

        return response.requireData;
      },
    );

    //
    tabScrollController.addListener(() {
      showLeft.value = tabScrollController.offset > 4;

      showRight.value =
          tabScrollController.offset <
          tabScrollController.position.maxScrollExtent - 4;
    });
    listScrollController.addListener(() {
      if (listScrollController.position.pixels >=
          listScrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });
  }

  Future<void> changeStatus(OfferStatus status) async {
    if (selectedStatus.value == status) return;

    selectedStatus.value = status;

    await paginator.loadInitial();
  }

  Future<void> loadOffers() async {
    debugPrint("Before: ${paginator.items.length}");

    await paginator.loadInitial();

    debugPrint("After: ${paginator.items.length}");
  }

  Future<void> loadMore() {
    return paginator.loadMore();
  }

  Future<void> refreshOffers() {
    return paginator.refresh();
  }

  @override
  void onClose() {
    tabScrollController.dispose();
    listScrollController.dispose();
    paginator.dispose();
    super.onClose();
  }

  ///
}
