import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../widgets/help_support_faq_section.dart';
import '../widgets/help_support_form_card.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.softBackgroundColor,

        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 18.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          AppStrings.helpSupport.tr,
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HelpSupportFormCard(),

              Gap(28.h),

              const HelpSupportFaqSection(),
            ],
          ),
        ),
      ),
    );
  }
}
