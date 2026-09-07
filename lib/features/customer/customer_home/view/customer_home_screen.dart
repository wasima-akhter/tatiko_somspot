import 'package:som_spot/features/core/category/controller/category_controller.dart';
import 'package:som_spot/features/customer/customer_home/controller/home_controller.dart';
import 'package:som_spot/features/customer/customer_home/widgets/home_header_widget.dart';
import 'package:som_spot/features/customer/customer_home/widgets/home_top_deals_widget.dart';
import 'package:som_spot/features/customer/customer_home/widgets/nearby/home_nearby_widget.dart';

import '../../../../share/export/screen_export.dart';
import '../widgets/category/home_categories_widget.dart';

class CustomerHomeScreen extends GetView<HomeController> {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await CategoryController.to.loadInitialCategories();
    });
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () => controller.refreshHomeData(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Header Widget placed inside a SliverToBoxAdapter
            const SliverToBoxAdapter(child: HomeHeaderWidget()),

            // Rest of the Home Screen content wrapped inside high-performance SliverPadding
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const HomeCategoriesWidget(),
                  // Gap(24.h),
                  // HomeTrendingContentWidget(),
                  Gap(24.h),
                  const HomeTopDealsWidget(),
                  Gap(24.h),
                  const HomeNearbyWidget(),

                  Gap(24.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
