import 'package:som_spot/helper/snackbar/api_snackbar.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../nav/controller/navigation_controller.dart';
import '../../../success/success_screen.dart';
import '../../core/influencer_tasks/service/influencer_tasks_service.dart';
import '../../influencer_task_screen/controller/influencer_task_controller.dart';
import '../../influencer_task_screen/helper/influencer_task_helper.dart';

class InfluencerPublishProofController extends GetxController {
  InfluencerPublishProofController(this._service);

  final InfluencerTasksService _service;

  static InfluencerPublishProofController get to => Get.find();

  final submitPostStatus = ApiStatus.completed.obs;

  String? submitPostError;

  Future<void> submitPost({
    required String applicationId,
    required String postUrl,
  }) async {
    final url = postUrl.trim();

    if (url.isEmpty) {
      ApiSnackbar.show(AppStrings.pleaseEnterSocialMediaPostUrl.tr);
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      ApiSnackbar.show(AppStrings.pleaseEnterValidPostUrl.tr);
      return;
    }

    submitPostStatus.value = ApiStatus.loading;
    submitPostError = null;

    final response = await _service.submitPostPublishUrl(
      applicationId: applicationId,
      postUrl: url,
    );

    if (!response.success) {
      submitPostStatus.value = ApiStatus.error;
      submitPostError = response.message;

      ApiSnackbar.show(response.message);
      return;
    }

    submitPostStatus.value = ApiStatus.completed;

    AppRouter.route.goNamed(
      RoutePath.successScreen,
      extra: SuccessScreenArgs(
        title: AppStrings.publishingConfirmed.tr,
        subtitle: AppStrings.campaignMovedToPublished.tr,
        autoNavigateAfter: const Duration(seconds: 3),
        onAutoNavigate: () {
          AppRouter.route.goNamed(RoutePath.navigationPages);

          if (Get.isRegistered<NavigationControllerMain>()) {
            NavigationControllerMain.to.goToTabTasks();

            if (Get.isRegistered<InfluencerTaskController>()) {
              InfluencerTaskController.to.selectedTab.value =
                  InfluencerTaskTab.published;
            }
          }
        },
      ),
    );
  }
}
