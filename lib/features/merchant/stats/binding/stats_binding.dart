import 'package:som_spot/features/merchant/stats/service/stats_service.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../controller/stats_controller.dart';

class StatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatsController>(
      () => StatsController(sl<StatsService>()),
      fenix: true,
    );
  }
}
