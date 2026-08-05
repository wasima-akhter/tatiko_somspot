import 'dart:io';

import '../../../../../share/export/repo_export.dart';
import '../../../../../utils/multipart/multipart_body.dart';
import '../request/influencer_tasks_request.dart';

class InfluencerTasksRepository {
  final ApiClient _apiClient;

  InfluencerTasksRepository(this._apiClient);

  Future<Response> getTasks(InfluencerTasksRequest request) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.creatorTasks(),
      queryParams: request.toQuery(),
    );
  }

  Future<Response> submitDraftCreatorVideo({
    required String applicationId,
    String? draftVideoUrl,
    File? draftVideo,
    String? draftMediaType,
    required String caption,
    required File thumbnail,
    required String platform,
  }) {
    final files = <MultipartBody>[
      MultipartBody(fieldKey: "thumbnail", file: thumbnail),
    ];

    final fields = <String, String>{
      "applicationId": applicationId,
      "caption": caption,
      "platform": platform,
    };

    if (draftVideo != null) {
      files.add(MultipartBody(fieldKey: "draftVideo", file: draftVideo));

      fields["draftMediaType"] = draftMediaType ?? "video";
    } else if (draftVideoUrl != null && draftVideoUrl.isNotEmpty) {
      fields["draftVideoUrl"] = draftVideoUrl;
    }

    return _apiClient.uploadMultipart(
      url: ApiUrls.submitDraftCreatorVideo(),
      method: "PATCH",
      files: files,
      fields: fields,
      showResponse: true,
    );
  }

  Future<Response> getTaskDetail(String applicationId) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.creatorTaskDetailsByCampId(),
      queryParams: {"applicationId": applicationId},
    );
  }

  Future<Response> submitPost({
    required String applicationId,
    required String postUrl,
  }) {
    return _apiClient.patch(
      url: ApiUrls.submitCreatorPost(),
      body: {"applicationId": applicationId, "postUrl": postUrl},
      showResponse: true,
    );
  }
}
