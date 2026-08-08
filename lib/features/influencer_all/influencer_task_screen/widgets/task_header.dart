import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
      child: Text(
        AppStrings.myTasks.tr,
        style: context.headlineSmall.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextColor,
        ),
      ),
    );
  }
}
