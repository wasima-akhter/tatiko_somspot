import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../model/category_model.dart';
import '../repository/category_repository.dart';
import '../service/category_service.dart';

class CategoryController extends GetxController {
  CategoryController(this._service, {required this.categoryUsageType});

  final CategoryService _service;
  final CategoryUsage categoryUsageType;

  // ---------------------------------------------------------------------------
  // Category Paginator & Scroll
  // ---------------------------------------------------------------------------

  late final Paginator<CategoryModel> categoryPaginator;
  final categoryScrollController = ScrollController();

  List<CategoryModel> get categories => categoryPaginator.items;

  @override
  void onInit() {
    super.onInit();
    _initCategoryPaginator();
    categoryScrollController.addListener(_onCategoryScroll);
    loadInitialCategories();
  }

  Future<void> loadInitialCategories() async {
    await categoryPaginator.loadInitial();
  }

  void _initCategoryPaginator() {
    categoryPaginator = Paginator<CategoryModel>(
      fetchPage: (page, limit) async {
        final response = await _service.getCategories(
          page: page,
          limit: limit,
          type: categoryUsageType,
        );
        return response.data!;
      },
    );
  }

  void _onCategoryScroll() {
    if (!categoryScrollController.hasClients) return;

    final position = categoryScrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreCategories();
    }
  }

  Future<void> loadMoreCategories() {
    return categoryPaginator.loadMore();
  }

  Future<void> refreshCategories() {
    return categoryPaginator.refresh();
  }

  @override
  void onClose() {
    categoryScrollController.removeListener(_onCategoryScroll);
    categoryScrollController.dispose();
    categoryPaginator.dispose();
    super.onClose();
  }
}
