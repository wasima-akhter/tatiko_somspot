import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        "My Tasks",
        style: context.headlineSmall.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextColor,
        ),
      ),
    );
  }
}
