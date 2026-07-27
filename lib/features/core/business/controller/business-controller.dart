import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../response/business-response.dart';
import '../service/business-service.dart';

class BusinessController extends GetxController {
  final BusinessService _service;

  BusinessController(this._service);

  static BusinessController get to => Get.find();

  late final Paginator<BusinessModel> myBusinessesPaginator;

  @override
  void onInit() {
    super.onInit();

    debugPrint("BusinessController onInit");

    myBusinessesPaginator = Paginator<BusinessModel>(
      fetchPage: (page, limit) async {
        debugPrint("Fetching businesses page=$page limit=$limit");

        final result = await _service.getMyBusinesses(page, limit);

        debugPrint("Businesses received: ${result.data.length}");

        return result;
      },
    );

    debugPrint("Calling loadInitial");

    myBusinessesPaginator.loadInitial();
  }

  Future<void> refreshBusinesses() async {
    await myBusinessesPaginator.refresh();
  }

  @override
  void onClose() {
    myBusinessesPaginator.dispose();

    super.onClose();
  }
}
