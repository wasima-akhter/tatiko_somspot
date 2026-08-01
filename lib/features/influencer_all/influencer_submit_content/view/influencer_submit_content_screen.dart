import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
import '../../../success/success_screen.dart';
import '../../influencer_task_screen/controller/influencer_task_controller.dart';

class InfluencerSubmitContentScreen extends StatefulWidget {
  const InfluencerSubmitContentScreen({super.key});

  @override
  State<InfluencerSubmitContentScreen> createState() =>
      _InfluencerSubmitContentScreenState();
}

class _InfluencerSubmitContentScreenState
    extends State<InfluencerSubmitContentScreen> {
  final TextEditingController _captionController = TextEditingController();

  File? _videoFile;

  Future<void> _pickVideo() async {
    final picker = ImagePicker();

    final XFile? file = await picker.pickVideo(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _videoFile = File(file.path);
      });
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      title: "Submit Content",
      onPressed: () => AppRouter.route.pop(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(12),

              /// Task Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffF5EDFF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    width: 2,
                    color: AppColors.grayTertiaryTextColor.withValues(
                      alpha: 0.2,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task: 1 TikTok Video",
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF581C87),
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "Upload your draft video for merchant approval.",
                      style: context.titleSmall.copyWith(
                        color: Colors.deepPurple,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(20),

              /// Upload Box
              GestureDetector(
                onTap: _pickVideo,
                child: Container(
                  height: 170.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      width: 3,
                      color: AppColors.backgroundsLinesColor,
                    ),
                  ),
                  child: _videoFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.purple.withValues(
                                alpha: .07,
                              ),
                              child: const Icon(
                                Icons.cloud_upload_outlined,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const Gap(14),
                            Text(
                              "Tap to upload video",
                              style: context.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              "MP4 or MOV, max 50MB",
                              style: context.bodySmall.copyWith(
                                color: AppColors.subtitleTextColor,
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              _videoFile!.path.split('/').last,
                              textAlign: TextAlign.center,
                              style: context.bodyMedium,
                            ),
                          ),
                        ),
                ),
              ),

              const Gap(24),

              Text(
                "Active Tasks",
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor,
                ),
              ),

              const Gap(12),

              CustomTextField(
                controller: _captionController,
                hintText: "Write your caption including required\nhashtags...",
                maxLines: null,
                minLines: 4,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: AppColors.backgroundsLinesColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: AppColors.backgroundsLinesColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
              ),

              const Gap(34),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onTap: () {
                    AppRouter.route.goNamed(
                      RoutePath.successScreen,
                      extra: SuccessScreenArgs(
                        title: "Content Submitted!",
                        subtitle:
                            "The merchant will review your content before you publish.",
                        autoNavigateAfter: const Duration(seconds: 3),
                        onAutoNavigate: () {
                          AppRouter.route.goNamed(RoutePath.navigationPages);
                          if (Get.isRegistered<NavigationControllerMain>()) {
                            NavigationControllerMain.to.goToTabTasks();
                            if (Get.isRegistered<InfluencerTaskController>()) {
                              InfluencerTaskController.to.selectedTab.value = 1;
                            }
                          }
                        },
                      ),
                    );
                  },
                  text: "Submit for Review",
                ),
              ),

              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}
