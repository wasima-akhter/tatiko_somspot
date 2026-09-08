import 'dart:io';

import 'package:som_spot/share/export/screen_export.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../core/influencer_tasks/request/influencer_tasks_request.dart';
import '../../core/influencer_tasks/response/influencer_tasks_response.dart';
import '../../core/influencer_tasks/service/influencer_tasks_service.dart';
import '../helper/influencer_task_helper.dart';

class InfluencerTaskController extends GetxController {
  final InfluencerTasksService _service;

  InfluencerTaskController(this._service);
  static InfluencerTaskController get to => Get.find();

  List<InfluencerTaskModel> get activeTasks =>
      mockInfluencerTasks.where((e) => e.stage == "active").toList();

  List<InfluencerTaskModel> get pendingTasks =>
      mockInfluencerTasks.where((e) => e.stage == "pending").toList();

  List<InfluencerTaskModel> get completedTasks =>
      mockInfluencerTasks.where((e) => e.stage == "completed").toList();

  List<InfluencerTaskModel> get publishedTasks =>
      mockInfluencerTasks.where((e) => e.stage == "published").toList();

  final listScrollController = ScrollController();

  late final Paginator<InfluencerTaskModel> paginator;

  final summary = Rxn<TaskSummaryModel>();

  @override
  void onInit() {
    super.onInit();

    paginator = Paginator<InfluencerTaskModel>(
      fetchPage: (page, limit) async {
        final response = await _service.getTasks(
          InfluencerTasksRequest(
            page: page,
            limit: limit,
            stage: selectedTab.value.apiValue,
          ),
        );

        final result = response.data;

        summary.value = result?.summary;

        return PaginatedResult<InfluencerTaskModel>(
          data: result!.data,
          meta: result.meta,
        );
      },
    );
    listScrollController.addListener(() {
      if (listScrollController.position.pixels >=
          listScrollController.position.maxScrollExtent - 200) {
        paginator.loadMore();
      }
    });
  }

  Future<void> loadTasks() {
    return paginator.loadInitial();
  }

  Future<void> refreshTasks() {
    return paginator.refresh();
  }

  final selectedTab = InfluencerTaskTab.active.obs;

  Future<void> changeTab(InfluencerTaskTab tab) async {
    if (selectedTab.value == tab) return;

    selectedTab.value = tab;

    await paginator.loadInitial();
  }

  @override
  void onClose() {
    listScrollController.dispose();
    paginator.dispose();
    super.onClose();
  }

  ///
  final submitDraftStatus = ApiStatus.completed.obs;
  String? submitDraftError;

  Future<bool> submitDraft({
    required String applicationId,

    // Either one
    String? draftVideoUrl,
    File? draftVideo,

    // Required
    required String caption,
    required File thumbnail,

    // Required only when uploading file
    String? draftMediaType,

    required String platform,
  }) async {
    submitDraftStatus.value = ApiStatus.loading;
    submitDraftError = null;

    final response = await _service.submitDraft(
      applicationId: applicationId,
      draftVideoUrl: draftVideoUrl,
      draftVideo: draftVideo,
      draftMediaType: draftMediaType,
      caption: caption,
      thumbnail: thumbnail,
      platform: platform,
    );

    if (!response.success) {
      submitDraftStatus.value = ApiStatus.error;
      submitDraftError = response.message;
      return false;
    }

    submitDraftStatus.value = ApiStatus.completed;
    return true;
  }

  //
  final taskDetailStatus = ApiStatus.completed.obs;

  final Rxn<InfluencerTaskModel> taskDetail = Rxn();

  String? taskDetailError;

  Future<void> loadTaskDetail(String applicationId) async {
    taskDetailStatus.value = ApiStatus.loading;
    taskDetailError = null;

    final response = await _service.getTaskDetail(applicationId);

    if (!response.success) {
      taskDetailStatus.value = ApiStatus.error;
      // taskDetailError = response.message;
      taskDetailError = AppStrings.invalidTaskInformation.tr;
      return;
    }

    taskDetail.value = response.data;

    taskDetailStatus.value = ApiStatus.completed;
  }

  //
}

final mockInfluencerTasks = [
  InfluencerTaskModel(
    id: "task_001",
    campaign: CampaignModel(
      id: "campaign_001",
      merchant: MerchantModel(id: "merchant_001", name: "Nike"),
      business: BusinessModel(
        id: "business_001",
        name: "Nike Bangladesh",
        logo: "https://picsum.photos/200/200?1",
      ),
      offer: "20% OFF on all running shoes",
      name: "Nike Running Campaign",
      about: "Promote the latest Nike running shoes.",
      contentType: "Reel",
      endDate: DateTime.now().add(const Duration(days: 30)),
      videoLengthSec: 30,
      pricePerClaim: 500,
    ),
    creator: "creator_001",
    status: "accepted",
    draftApproved: true,
    commissionAmount: 500,
    stage: InfluencerTaskTab.active,
    approvedAt: DateTime.now().subtract(const Duration(days: 2)),
    appliedAt: DateTime.now().subtract(const Duration(days: 5)),
    createdAt: DateTime.now().subtract(const Duration(days: 6)),
    updatedAt: DateTime.now(),
  ),

  InfluencerTaskModel(
    id: "task_002",
    campaign: CampaignModel(
      id: "campaign_002",
      merchant: MerchantModel(id: "merchant_002", name: "Adidas"),
      business: BusinessModel(
        id: "business_002",
        name: "Adidas Store",
        logo: "https://picsum.photos/200/200?2",
      ),
      offer: "Buy 1 Get 1",
      name: "Adidas Sneakers",
      about: "Showcase Adidas sneakers in a lifestyle video.",
      contentType: "Story",
      endDate: DateTime.now().add(const Duration(days: 15)),
      videoLengthSec: 15,
      pricePerClaim: 350,
    ),
    creator: "creator_002",
    status: "pending",
    draftApproved: false,
    commissionAmount: 350,
    stage: InfluencerTaskTab.pending,
    approvedAt: null,
    appliedAt: DateTime.now().subtract(const Duration(days: 1)),
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now(),
  ),

  InfluencerTaskModel(
    id: "task_003",
    campaign: CampaignModel(
      id: "campaign_003",
      merchant: MerchantModel(id: "merchant_003", name: "Starbucks"),
      business: BusinessModel(
        id: "business_003",
        name: "Starbucks Coffee",
        logo: "https://picsum.photos/200/200?3",
      ),
      offer: "Free Coffee",
      name: "Morning Coffee",
      about: "Create a morning routine vlog featuring Starbucks.",
      contentType: "TikTok",
      endDate: DateTime.now().add(const Duration(days: 10)),
      videoLengthSec: 45,
      pricePerClaim: 700,
    ),
    creator: "creator_003",
    status: "completed",
    draftApproved: true,
    commissionAmount: 700,
    stage: InfluencerTaskTab.pending,
    approvedAt: DateTime.now().subtract(const Duration(days: 7)),
    appliedAt: DateTime.now().subtract(const Duration(days: 10)),
    createdAt: DateTime.now().subtract(const Duration(days: 12)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),

  InfluencerTaskModel(
    id: "task_004",
    campaign: CampaignModel(
      id: "campaign_004",
      merchant: MerchantModel(id: "merchant_004", name: "Apple"),
      business: BusinessModel(
        id: "business_004",
        name: "Apple Store",
        logo: "https://picsum.photos/200/200?4",
      ),
      offer: "iPhone Giveaway",
      name: "Shot on iPhone",
      about: "Create cinematic videos using an iPhone.",
      contentType: "YouTube",
      endDate: DateTime.now().add(const Duration(days: 45)),
      videoLengthSec: 120,
      pricePerClaim: 1500,
    ),
    creator: "creator_004",
    status: "published",
    draftApproved: true,
    commissionAmount: 1500,
    stage: InfluencerTaskTab.published,
    approvedAt: DateTime.now().subtract(const Duration(days: 20)),
    appliedAt: DateTime.now().subtract(const Duration(days: 25)),
    createdAt: DateTime.now().subtract(const Duration(days: 26)),
    updatedAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
];

final mockTaskSummary = TaskSummaryModel(
  active: 1,
  pending: 1,
  completed: 1,
  published: 1,
);
