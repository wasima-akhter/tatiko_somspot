import '../../../../features/merchant/merchant_campaign_details/widgets/merchant_campaign_influencer_card.dart';
import '../../../controller/screen_export.dart';

class InfluencerRequestBottomSheet extends StatelessWidget {
  final InfluencerModel influencer;

  const InfluencerRequestBottomSheet({super.key, required this.influencer});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 30.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Drag Handle
            Container(
              width: 45.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),

            SizedBox(height: 22.h),

            /// Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundImage: NetworkImage(influencer.image),
                ),

                SizedBox(width: 14.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        influencer.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        influencer.category,
                        style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            SizedBox(height: 22.h),

            /// Stats
            Row(
              children: [
                Expanded(
                  child: _StatCard(title: "50K", subtitle: "Followers"),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _StatCard(title: "4.2%", subtitle: "Engage"),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _StatCard(title: "12", subtitle: "Done"),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            /// Pitch
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pitch",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(height: 10.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                influencer.pitch,
                style: TextStyle(fontSize: 14.sp, height: 1.5),
              ),
            ),

            SizedBox(height: 28.h),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(52.h),
                      side: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      "Reject",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 14.w),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(52.h),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: const Text("Approve"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _StatCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : const Color(0xffF7F8FC),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
