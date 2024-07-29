import 'dart:developer';

import 'package:abramo_coffee/models/menu_model.dart';
import 'package:abramo_coffee/providers/menus_provider.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenusController extends GetxController {
  Rx<bool> isLoading = false.obs;
  final _box = GetStorage();

  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> codeController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> qtyController = TextEditingController().obs;
  RxInt categoryId = 0.obs;
  RxInt selectedCategoryId = 0.obs;
  RxString status = "".obs;
  RxString searchQuery = "".obs;

  RxList<String> listStatus = ["Aktif", "Tidak Aktif"].obs;
  // RxList<String> listFavorite = ["Favorite", "Tidak Favorite"].obs;

  Rx<MenuModel> menuModel = MenuModel().obs;
  RxList<MenuModel> listMenuModel = <MenuModel>[].obs;
  RxList<MenuModel> listMenuSearchModel = <MenuModel>[].obs;

  @override
  void onInit() {
    getAllMenu();
    super.onInit();
  }

  populateFieldWhenEdit(MenuModel menuModel) {
    codeController.value.text = menuModel.code!;
    nameController.value.text = menuModel.name!;
    descriptionController.value.text = menuModel.description!;
    priceController.value.text = menuModel.price!.toString();
    qtyController.value.text = menuModel.qty!.toString();
  }

  void reset() {
    codeController.value.clear();
    nameController.value.clear();
    descriptionController.value.clear();
    priceController.value.clear();
    qtyController.value.clear();
  }

  void updateSearchQuery(String query) async {
    // searchQuery.value = query;
    // if (query.isEmpty) {
    // } else {
    try {
      var listMenu = await MenusProvider.getAllMenuBySearch(query);
      listMenuModel.value = listMenu;
      log("List menu search ditampilkan = $listMenuModel");
    } catch (e) {
      log("Error $e");
    }
    // }
  }

  void updateSearchCategory(int id) async {
    selectedCategoryId.value = id;
    try {
      var listMenu = await MenusProvider.getAllMenuByCategoryId(id);
      listMenuModel.value = listMenu;
      log("List menu search ditampilkan = $listMenuModel");
    } catch (e) {
      log("Error $e");
    }
  }

  void getAllMenuFilter(String? query, int? categoryId) async {
    isLoading.value = true;
    searchQuery.value = query ?? "";

    try {
      if (query != null) {
        var listMenu = await MenusProvider.getAllMenuBySearch(query);
        listMenuModel.value = listMenu;
        log("List menu search ditampilkan = $listMenuModel");
      }

      if (categoryId != null) {
        var listMenu = await MenusProvider.getAllMenuByCategoryId(categoryId);
        listMenuModel.value = listMenu;
        log("List menu category ditampilkan = $listMenuModel");
      }

      if (categoryId == null && query == null) {
        var listMenu = await MenusProvider.getAllMenu();
        listMenuModel.value = listMenu;
        log("List menu  ditampilkan = $listMenuModel");
      }
    } catch (e) {
      log("Error : $e");
    }
  }

  Future getMenu(int id) async {
    try {
      isLoading.value = true;
      log("hehe");
      final menu = await MenusProvider.getMenu(id);
      menuModel.value = menu;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAllMenu() async {
    try {
      isLoading.value = true;
      final listMenu = await MenusProvider.getAllMenu();
      listMenuModel.value = listMenu;
      listMenuSearchModel.value = listMenu;

      log("List Menu model : $listMenu.");

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAllMenuBySearch(String query) async {
    try {
      isLoading.value = true;
      final listMenuSearch = await MenusProvider.getAllMenuBySearch(query);
      listMenuModel.value = listMenuSearch;

      log("List Menu Search model : $listMenuSearch");

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAllMenuByCategoryId(int id) async {
    try {
      isLoading.value = true;
      final listMenuSearch = await MenusProvider.getAllMenuByCategoryId(id);
      listMenuModel.value = listMenuSearch;

      log("List Menu Category model : $listMenuSearch");

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addMenu() async {
    final imagePath = _box.read(currentPathImg);
    log("IMAGE => $imagePath");
    try {
      isLoading.value = true;

      var res = await MenusProvider.addMenu(
          codeController.value.text,
          categoryId.value,
          nameController.value.text,
          descriptionController.value.text,
          imagePath,
          int.parse(priceController.value.text),
          0,
          "aktif");

      isLoading.value = false;
      reset();
      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> editMenu(MenuModel menuModel) async {
    String? imagePath = _box.read(currentPathImg);
    log("NEW-IMAGE => $imagePath");
    log("Menu Model => $menuModel");
    log("Menu Model id => ${menuModel.id}");
    log("Menu Model Code => => ${codeController.value.text}");
    log("Menu Model qty => ${int.parse(qtyController.value.text)}");

    try {
      isLoading.value = true;
      var res = await MenusProvider.editMenu(
        menuModel.id!,
        codeController.value.text,
        categoryId.value,
        nameController.value.text,
        descriptionController.value.text,
        imagePath ?? "",
        menuModel.image ?? "",
        int.parse(priceController.value.text),
        int.parse(qtyController.value.text),
        "aktif",
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

  Future<bool> editMenuKitchen(MenuModel menuModel) async {
    String? imagePath = _box.read(currentPathImg);
    log("NEW-IMAGE => $imagePath");
    log("Menu Model => $menuModel");
    log("Menu Model id => ${menuModel.qty}");
    log("Menu Model Code => => ${menuModel.code}");
    log("Menu Model QTY => ${menuModel.qty}");

    try {
      isLoading.value = true;
      var res = await MenusProvider.editMenuKitchen(
        menuModel.id!,
        menuModel.code!,
        menuModel.categoryId!,
        menuModel.name!,
        menuModel.description!,
        menuModel.image ?? "",
        menuModel.image ?? "",
        menuModel.price!,
        menuModel.qty!,
        menuModel.status!,
      );
      isLoading.value = false;

      log("RES => $res");

      reset();

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteMenu(MenuModel menuModel) async {
    try {
      isLoading.value = true;
      var res = await MenusProvider.deleteMenu(
        menuModel.id!,
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




  // convertData(String dataName) {
  //   switch (dataName) {
  //     case "Favorite":
  //       isFavorite.value = 1;
  //       log(isFavorite.value.toString());
  //       return isFavorite.value;
  //     case "Tidak Favorite":
  //       isFavorite.value = 0;
  //       log(isFavorite.value.toString());
  //       return isFavorite;
  //     case "Aktif":
  //       status.value = 1;
  //       log(status.value.toString());
  //       return status.value;
  //     case "Tidak Aktif":
  //       status.value = 0;
  //       log(status.value.toString());
  //       return status.value;
  //     default:
  //       break;
  //   }
  // }