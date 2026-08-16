import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/helper/snackbar/api_snackbar.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/dropdown/custom_dropdown_field.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
import '../../../success/success_screen.dart';
import '../../influencer_task_screen/controller/influencer_task_controller.dart';
import '../../influencer_task_screen/helper/influencer_task_helper.dart';
import '../args/submit_content_args.dart';

class InfluencerSubmitContentScreen extends StatefulWidget {
  final SubmitContentArgs args;

  const InfluencerSubmitContentScreen({super.key, required this.args});

  @override
  State<InfluencerSubmitContentScreen> createState() =>
      _InfluencerSubmitContentScreenState();
}

class _InfluencerSubmitContentScreenState
    extends State<InfluencerSubmitContentScreen> {
  final TextEditingController _videoUrlController = TextEditingController();

  final TextEditingController _captionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  File? _thumbnail;
  File? _draftVideo;

  String? _selectedPlatform;

  final List<String> _platforms = [
    AppStrings.tiktok.tr,
    AppStrings.instagram.tr,
    AppStrings.facebook.tr,
    AppStrings.youtube.tr,
  ];

  Future<void> _pickThumbnail() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,

      imageQuality: 85,
    );

    if (file == null) return;

    setState(() {
      _thumbnail = File(file.path);
    });
  }

  Future<void> _pickVideo() async {
    final file = await _picker.pickVideo(source: ImageSource.gallery);

    if (file == null) return;

    setState(() {
      _draftVideo = File(file.path);
    });
  }

  @override
  void dispose() {
    _videoUrlController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      title: AppStrings.submitContent.tr,
      onPressed: () => AppRouter.route.pop(),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Task Information
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),

                  decoration: BoxDecoration(
                    color: const Color(0xffF5EDFF),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: AppColors.grayTertiaryTextColor.withValues(
                        alpha: .2,
                      ),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "${AppStrings.task.tr}: ${widget.args.taskName}",
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff581C87),
                        ),
                      ),

                      Gap(6.h),

                      Text(
                        AppStrings
                            .submitPublishedVideoLinkForMerchantApproval
                            .tr,
                        style: context.bodySmall.copyWith(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(14.h),

                Text(
                  AppStrings.platform.tr,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(10.h),

                CustomDropdownField<String>(
                  value: _selectedPlatform,
                  hintText: AppStrings.selectPlatform.tr,
                  items: _platforms,
                  labelBuilder: (platform) =>
                      platform[0].toUpperCase() + platform.substring(1),
                  onChanged: (value) {
                    setState(() {
                      _selectedPlatform = value?.toLowerCase();
                    });
                  },
                ),
                Gap(10.h),

                Text(
                  AppStrings.caption.tr,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(10.h),

                CustomTextField(
                  controller: _captionController,
                  hintText: AppStrings.writeCaptionUsedInYourPost.tr,
                  fillColor: Colors.white,
                  maxLines: 4,
                  minLines: 2,
                ),
                Gap(20.h),

                Text(
                  AppStrings.thumbnail.tr,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(10.h),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _pickThumbnail,
                  child: Container(
                    height: 120.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: AppColors.backgroundsLinesColor,
                      ),
                    ),
                    child: _thumbnail == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.image_outlined),
                              Gap(8.h),
                              Text(AppStrings.selectThumbnail.tr),
                            ],
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14.r),
                                child: Image.file(
                                  _thumbnail!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: _pickThumbnail,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Gap(14.h),

                Text(
                  AppStrings.uploadVideoOptional.tr,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(10.h),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _pickVideo,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 18.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: AppColors.backgroundsLinesColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.video_library_outlined),

                        Gap(12.w),

                        Expanded(
                          child: Text(
                            _draftVideo == null
                                ? AppStrings.chooseVideo.tr
                                : _draftVideo!.path.split('/').last,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        if (_draftVideo != null)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _draftVideo = null;
                              });
                            },
                            icon: const Icon(Icons.close),
                          ),
                      ],
                    ),
                  ),
                ),
                Gap(14.h),

                /// Video URL
                Text(
                  AppStrings.videoLink.tr,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(10.h),

                CustomTextField(
                  controller: _videoUrlController,
                  hintText: AppStrings.pasteSocialVideoUrl.tr,
                  fillColor: Colors.white,

                  prefixIcon: const Icon(Icons.link, color: Colors.grey),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(
                      color: AppColors.backgroundsLinesColor,
                    ),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(
                      color: AppColors.backgroundsLinesColor,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                Gap(24.h),

                Obx(
                  () => SizedBox(
                    width: double.infinity,

                    child: CustomButton(
                      isLoading:
                          InfluencerTaskController.to.submitDraftStatus.value ==
                          ApiStatus.loading,
                      text: AppStrings.submitForReview.tr,
                      onTap: _submitContent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitContent() async {
    if (_draftVideo == null && _videoUrlController.text.trim().isEmpty) {
      ApiSnackbar.show(AppStrings.uploadVideoOrProvideVideoUrl.tr);
      return;
    }

    if (_captionController.text.trim().isEmpty) {
      ApiSnackbar.show(AppStrings.enterCaption.tr);
      return;
    }

    if (_thumbnail == null) {
      ApiSnackbar.show(AppStrings.selectThumbnailRequired.tr);
      return;
    }

    if (_selectedPlatform == null) {
      ApiSnackbar.show(AppStrings.selectPlatformRequired.tr);
      return;
    }
    final success = await InfluencerTaskController.to.submitDraft(
      applicationId: widget.args.applicationId,
      draftVideoUrl: _draftVideo == null
          ? _videoUrlController.text.trim()
          : null,
      draftVideo: _draftVideo,
      draftMediaType: _draftVideo != null ? AppStrings.video.tr : null,
      caption: _captionController.text.trim(),
      thumbnail: _thumbnail!,
      platform: _selectedPlatform ?? '',
    );
    if (!success) return;

    AppRouter.route.goNamed(
      RoutePath.successScreen,
      extra: SuccessScreenArgs(
        title: AppStrings.contentSubmitted.tr,
        subtitle: AppStrings.merchantWillReviewContent.tr,
        autoNavigateAfter: const Duration(seconds: 3),
        onAutoNavigate: () {
          AppRouter.route.goNamed(RoutePath.navigationPages);

          if (Get.isRegistered<NavigationControllerMain>()) {
            NavigationControllerMain.to.goToTabTasks();

            if (Get.isRegistered<InfluencerTaskController>()) {
              InfluencerTaskController.to.selectedTab.value =
                  InfluencerTaskTab.pending;

              InfluencerTaskController.to.refreshTasks();
            }
          }
        },
      ),
    );
  }
}
