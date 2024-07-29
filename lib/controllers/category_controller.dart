import 'dart:developer';

import 'package:abramo_coffee/models/category_model.dart';
import 'package:abramo_coffee/providers/category_provider.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryController extends GetxController {
  Rx<bool> isLoading = false.obs;
  final _box = GetStorage();

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  RxList<CategoryModel> listCategoryModel = <CategoryModel>[].obs;

  @override
  void onInit() {
    getAllCategory();
    super.onInit();
  }

  populateFieldWhenEdit(CategoryModel categoryModel) {
    nameController.value.text = categoryModel.name!;
    descriptionController.value.text = categoryModel.description!;
  }

  void reset() {
    nameController.value.clear();
    descriptionController.value.clear();
  }

  Future getCategory(int id) async {
    try {
      isLoading.value = true;
      log("hehe");
      final category = await CategoryProvider.getCategory(id);
      categoryModel.value = category;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAllCategory() async {
    try {
      isLoading.value = true;
      log("hehe");
      final listCategory = await CategoryProvider.getAllCategory();
      listCategoryModel.value = listCategory;

      log("List category : $listCategoryModel");
      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addCategory() async {
    final imagePath = _box.read(currentPathImg);
    log("IMAGE => $imagePath");
    try {
      isLoading.value = true;

      var res = await CategoryProvider.addCategory(nameController.value.text,
          descriptionController.value.text, imagePath);

      isLoading.value = false;
      reset();
      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> editCategory(CategoryModel categoryModel) async {
    String? imagePath = _box.read(currentPathImg);
    log("NEW-IMAGE => $imagePath");

    try {
      isLoading.value = true;
      var res = await CategoryProvider.editCategory(
        categoryModel.id!,
        nameController.value.text,
        descriptionController.value.text,
        imagePath ?? "",
        categoryModel.image ?? "",
      );
      isLoading.value = false;

      reset();

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteCategory(CategoryModel categoryModel) async {
    try {
      isLoading.value = true;
      var res = await CategoryProvider.deleteCategory(
        categoryModel.id!,
      );
      isLoading.value = false;

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }
}
