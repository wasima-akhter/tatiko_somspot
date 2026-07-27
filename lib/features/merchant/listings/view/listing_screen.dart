import 'package:som_spot/features/merchant/listings/widgets/listing_business_card.dart';
import 'package:som_spot/features/merchant/listings/widgets/listing_header.dart';
import 'package:som_spot/features/merchant/listings/widgets/manage_business_menu.dart';

import '../../../../share/controller/screen_export.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Section ──
            const ListingHeader(),
            Gap(20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Business Card ──
                  const ListingBusinessCard(),
                  Gap(24.h),

                  // ── Manage Business Section ──
                  Text(
                    AppStrings.manageBusiness.tr,
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  Gap(12.h),

                  TextButton(
                    onPressed: () => AppRouter.route.pushNamed(
                      RoutePath.completeBusinessProfileScreen,
                    ),
                    child: Text("to complete bussiness profile"),
                  ),
                  const ManageBusinessMenu(),
                  Gap(40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
