import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CampaignBottomButtons extends StatelessWidget {
  final VoidCallback onNext;

  const CampaignBottomButtons({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),

      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },

              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),

                side: const BorderSide(color: Color(0xff45A7F5)),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),

              child: const Text("Cancel"),
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: ElevatedButton(
              onPressed: onNext,

              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),

                backgroundColor: const Color(0xff45A7F5),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),

              child: const Text("Next", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
