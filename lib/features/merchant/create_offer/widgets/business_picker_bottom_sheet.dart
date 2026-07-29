import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import '../../../core/business/controller/business-controller.dart';
import '../controller/create_offer_controller.dart';

void _showBusinessPicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return BusinessPickerBottomSheet();
    },
  );
}

class BusinessPickerBottomSheet extends StatelessWidget {
  const BusinessPickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateOfferController.to;
    final businessController = BusinessController.to;
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Obx(() {
        final businesses = businessController.myBusinessesPaginator.items;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: businesses.length,
          separatorBuilder: (_, _) => Gap(10.h),
          itemBuilder: (_, index) {
            final business = businesses[index];

            final isSelected = true;
            // controller.selectedBusiness.value?.id == business.id;

            return Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.blueAccentColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                title: Text(
                  business.name.capitalizeWords(),
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check_circle, color: AppColors.blueAccentColor)
                    : null,
                onTap: () {
                  // controller.selectBusiness(business);
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
