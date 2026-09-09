import 'dart:io';

import 'package:get/get.dart';

import '../../../../../share/export/service_export.dart';
import '../../../../../share/model/pagination_meta_model.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../repository/influencer_tasks_repository.dart';
import '../request/influencer_tasks_request.dart';
import '../response/influencer_tasks_response.dart';

class InfluencerTasksService {
  final InfluencerTasksRepository _repository;

  InfluencerTasksService(this._repository);

  Future<ApiResponse<InfluencerTasksResponse>> getTasks(
    InfluencerTasksRequest request,
  ) async {
    try {
      final response = await _repository.getTasks(request);

      final data = response.data["data"];

      return ApiResponse.success(
        data: InfluencerTasksResponse(
          meta: PaginationMeta.fromJson(data["meta"]),
          summary: data["summary"] != null
              ? TaskSummaryModel.fromJson(data["summary"])
              : null,
          data: List<InfluencerTaskModel>.from(
            data["result"].map((e) => InfluencerTaskModel.fromJson(e)),
          ),
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Get Influencer Tasks Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  //
  Future<ApiResponse<void>> submitDraft({
    required String applicationId,
    String? draftVideoUrl,
    File? draftVideo,
    String? draftMediaType,
    required String caption,
    required File thumbnail,
    required String platform,
  }) async {
    try {
      await _repository.submitDraftCreatorVideo(
        applicationId: applicationId,
        draftVideoUrl: draftVideoUrl,
        draftVideo: draftVideo,
        draftMediaType: draftMediaType,
        caption: caption,
        thumbnail: thumbnail,
        platform: platform,
      );

      return ApiResponse.success(data: null);
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Submit Draft Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  //
  Future<ApiResponse<InfluencerTaskModel>> getTaskDetail(
    String applicationId,
  ) async {
    try {
      final response = await _repository.getTaskDetail(applicationId);

      final data = response.data["data"];

      return ApiResponse.success(data: InfluencerTaskModel.fromJson(data));
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Get Task Detail Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  //
  Future<ApiResponse<void>> submitPostPublishUrl({
    required String applicationId,
    required String postUrl,
  }) async {
    try {
      await _repository.submitPost(
        applicationId: applicationId,
        postUrl: postUrl,
      );

      return ApiResponse.success(data: null);
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Submit Post Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
