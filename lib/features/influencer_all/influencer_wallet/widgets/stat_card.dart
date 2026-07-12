import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundColor: iconColor.withOpacity(.12),
            child: Icon(icon, color: iconColor, size: 15.sp),
          ),

          SizedBox(height: 10.h),

          Text(
            title,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey),
          ),

          SizedBox(height: 5.h),

          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
        ],
      ),
    );
  }
}
