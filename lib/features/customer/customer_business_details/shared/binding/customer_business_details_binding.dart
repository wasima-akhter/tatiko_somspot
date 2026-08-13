import 'package:get/get.dart';
import 'package:som_spot/core/di/repo_service_injection.dart';
import 'package:som_spot/features/customer/customer_business_details/controller/customer_business_details_controller.dart';
import 'package:som_spot/features/customer/customer_business_details/shared/service/customer_business_details_service.dart';
import 'package:som_spot/features/customer/review/service/review_service.dart';
import 'package:som_spot/features/customer/saved/shared/service/saved_service.dart';

class CustomerBusinessDetailsBinding extends Bindings {
  final String businessId;

  CustomerBusinessDetailsBinding({required this.businessId});

  @override
  void dependencies() {
    Get.lazyPut<CustomerBusinessDetailsController>(
      () => CustomerBusinessDetailsController(
        sl<CustomerBusinessDetailsService>(),
        reviewService: sl<ReviewService>(),
        savedService: sl<SavedService>(),
        businessId: businessId,
      ),
    );
  }
}
