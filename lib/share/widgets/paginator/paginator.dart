// core/utils/paginator.dart

import 'package:get/get.dart';

import '../../../utils/enum/app_enum.dart';
import '../../model/pagination_meta_model.dart';

class Paginator<T> {
  final RxList<T> items = <T>[].obs;

  final Rx<ApiStatus> status = ApiStatus.completed.obs;
  final Rx<ApiStatus> loadMoreStatus = ApiStatus.completed.obs;

  final RxBool hasMore = true.obs;
  final RxString errorMessage = ''.obs;

  int _page = 1;
  final int limit;

  final Future<PaginatedResult<T>> Function(int page, int limit) fetchPage;

  Paginator({required this.fetchPage, this.limit = 10});

  int get currentPage => _page;

  /*
  Future<void> loadInitial() async {
    _page = 1;
    hasMore.value = true;
    items.clear();

    status.value = ApiStatus.loading;
    errorMessage.value = '';

    try {
      final result = await fetchPage(_page, limit);

      if (result.data.isEmpty) {
        status.value = ApiStatus.noDataFound;
        return;
      }
      items.clear();
      items.assignAll(result.data);

      hasMore.value = result.meta?.hasNextPage ?? false;

      if (hasMore.value) {
        _page++;
      }

      status.value = ApiStatus.completed;
    } catch (e) {
      errorMessage.value = e.toString();
      status.value = ApiStatus.error;
    }
  }
*/

  int _requestId = 0;

  Future<void> loadInitial() async {
    final requestId = ++_requestId;

    _page = 1;
    hasMore.value = true;

    status.value = ApiStatus.loading;
    errorMessage.value = '';

    try {
      final result = await fetchPage(_page, limit);

      // Ignore an older request if another request started after it.
      if (requestId != _requestId) {
        return;
      }

      items.assignAll(result.data);

      hasMore.value = result.meta?.hasNextPage ?? false;

      if (hasMore.value) {
        _page++;
      }

      status.value = result.data.isEmpty
          ? ApiStatus.noDataFound
          : ApiStatus.completed;
    } catch (e) {
      if (requestId != _requestId) {
        return;
      }

      errorMessage.value = e.toString();
      status.value = ApiStatus.error;
    }
  }

  Future<void> loadMore() async {
    if (loadMoreStatus.value == ApiStatus.loading ||
        status.value == ApiStatus.loading ||
        !hasMore.value) {
      return;
    }

    loadMoreStatus.value = ApiStatus.loading;

    try {
      final result = await fetchPage(_page, limit);

      items.addAll(result.data);

      hasMore.value = result.meta?.hasNextPage ?? false;

      if (hasMore.value) {
        _page++;
      }

      loadMoreStatus.value = ApiStatus.completed;
    } catch (e) {
      errorMessage.value = e.toString();
      loadMoreStatus.value = ApiStatus.error;
    }
  }

  Future<void> refresh() async {
    await loadInitial();
  }

  void reset() {
    items.clear();

    _page = 1;

    hasMore.value = true;

    status.value = ApiStatus.completed;
    loadMoreStatus.value = ApiStatus.completed;

    errorMessage.value = '';
  }

  void dispose() {
    items.close();
    status.close();
    loadMoreStatus.close();
    hasMore.close();
    errorMessage.close();
  }
}

class SummaryModel {
  final int active;
  final int inReview;

  SummaryModel({this.active = 0, this.inReview = 0});

  factory SummaryModel.fromJson(Map<String, dynamic>? json) {
    return SummaryModel(
      active: json?['active'] ?? 0,
      inReview: json?['inReview'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'active': active, 'inReview': inReview};
  }
}

class PaginatedResult<T> {
  final List<T> data;
  final PaginationMeta? meta;
  final SummaryModel? summary;

  PaginatedResult({required this.data, this.meta, this.summary});
}
