import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/customer/home/controller/home_controller.dart';
import 'package:som_spot/features/customer/home/widgets/home_deals_widget.dart';
import 'package:som_spot/features/customer/home/widgets/home_header_widget.dart';
import 'package:som_spot/features/customer/home/widgets/home_nearby_widget.dart';
import 'package:som_spot/features/customer/home/widgets/home_top_deals_widget.dart';
import 'package:som_spot/utils/color/app_colors.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
                  // const HomeCategoriesWidget(),
                  Gap(24.h),
                  const HomeDealsWidget(),
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
