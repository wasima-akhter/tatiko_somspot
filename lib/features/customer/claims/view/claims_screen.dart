import 'package:som_spot/features/customer/claims/controller/claims_controller.dart';
import 'package:som_spot/features/customer/claims/widgets/active_claims_list_widget.dart';

import '../../../../share/export/screen_export.dart';
import '../shared/helper/claims_helper.dart';
import '../widgets/claims_header_widget.dart';
import '../widgets/expired_claims_list_widget.dart';

class ClaimsScreen extends GetView<ClaimsController> {
  const ClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: AppColors.white),
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Column(
          children: [
            const ClaimsHeaderWidget(),

            Expanded(
              // height: 500,
              child: Container(
                width: double.infinity,
                color: AppColors.primaryColor.withValues(alpha: 0.05),
                child: Obx(() {
                  final isActive =
                      controller.rxSelectedTab.value == ClaimsTabType.active;

                  return
                  // Text("data");
                  isActive
                      ? const ActiveClaimsListWidget()
                      : const ExpiredClaimsListWidget();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
