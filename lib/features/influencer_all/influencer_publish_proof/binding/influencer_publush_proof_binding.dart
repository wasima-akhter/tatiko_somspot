import 'package:som_spot/core/di/repo_service_injection.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../core/influencer_tasks/service/influencer_tasks_service.dart';
import '../controller/influencer_publish_proof_controller.dart';

class InfluencerPublushProofBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => InfluencerPublishProofController(sl<InfluencerTasksService>()),
    );
  }
}
