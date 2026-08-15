import 'package:som_spot/features/customer/saved/controller/saved_controller.dart';

import '../../../../share/controller/screen_export.dart';
import '../helper/saved_helper.dart';
import '../widgets/saved_businesses_list_widget.dart';
import '../widgets/saved_header_widget.dart';
import '../widgets/saved_offers_list_widget.dart';

class SavedScreen extends GetView<SavedScreenController> {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: AppColors.white),
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Column(
          children: [
            const SavedHeaderWidget(),

            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColors.primaryColor.withValues(alpha: 0.05),
                child: Obx(() {
                  final isBusinesses =
                      controller.rxSelectedTab.value == SavedTabType.businesses;

                  return isBusinesses
                      ? const SavedBusinessesListWidget()
                      : const SavedOffersListWidget();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
