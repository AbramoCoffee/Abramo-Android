import 'dart:convert';
import 'dart:developer';
import 'package:abramo_coffee/models/menu_model.dart';
import 'package:abramo_coffee/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import '../resources/constant.dart';
import '../resources/endpoint.dart';

class MenusProvider {
  static Future<MenuModel> getMenu(int id) async {
    String menuUrl = "$baseUrl${Endpoint.api_menus_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await http.get(
        Uri.parse(menuUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      log("Menu Model => ${responseJson['data']}");

      return MenuModel.fromJson(responseJson['data']);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<MenuModel>> getAllMenu() async {
    String menuUrl = baseUrl + Endpoint.api_menus;

    final authData = await AuthProvider.getAuthData();

    List<MenuModel> listMenuModel = [];

    log("Token :  ${authData.token}");

    try {
      var response = await http.get(
        Uri.parse(menuUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          MenuModel menuModel = MenuModel.fromJson(data);
          listMenuModel.add(menuModel);
        }
      }

      log("List Menu Model => $listMenuModel");

      return listMenuModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<MenuModel>> getAllMenuBySearch(String query) async {
    String menuUrl = "$baseUrl${Endpoint.api_menus_search}$query";

    final authData = await AuthProvider.getAuthData();

    List<MenuModel> listMenuModel = [];

    log("Token :  ${authData.token}");

    try {
      var response = await http.get(
        Uri.parse(menuUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          MenuModel menuModel = MenuModel.fromJson(data);
          listMenuModel.add(menuModel);
        }
      }

      log("List Menu Model => $listMenuModel");

      return listMenuModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<MenuModel>> getAllMenuByCategoryId(int id) async {
    String menuUrl = "$baseUrl${Endpoint.api_menus_category}$id";

    final authData = await AuthProvider.getAuthData();

    List<MenuModel> listMenuModel = [];

    log("Token :  ${authData.token}");

    try {
      var response = await http.get(
        Uri.parse(menuUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          MenuModel menuModel = MenuModel.fromJson(data);
          listMenuModel.add(menuModel);
        }
      }

      log("List Menu Model => $listMenuModel");

      return listMenuModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addMenu(
    String code,
    int categoryId,
    String name,
    String description,
    String imagePath,
    int price,
    int qty,
    String status,
  ) async {
    final Dio dio = Dio();

    String menuUrl = baseUrl + Endpoint.api_menus;

    final authData = await AuthProvider.getAuthData();

    final box = GetStorage();

    log("qty == $qty");
    log("price == $price");

    try {
      var response = await dio.post(
        menuUrl,
        data: FormData.fromMap(
          {
            'code': code,
            'category_id': categoryId,
            'name': name,
            'description': description,
            'image': await MultipartFile.fromFile(imagePath),
            'price': price,
            'qty': qty,
            'status': status,
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.token}',
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Menu berhasil ditambahkan");

        box.remove(currentPathImg);
        return true;
      } else {
        Get.snackbar("Gagal", response.data['message'].toString());
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  static Future<bool> editMenu(
    int id,
    String code,
    int categoryId,
    String name,
    String description,
    String newImagePath,
    String oldImagePath,
    int price,
    int qty,
    String status,
  ) async {
    final Dio dio = Dio();

    String menuUrl = "$baseUrl${Endpoint.api_menus_id}$id";

    final authData = await AuthProvider.getAuthData();

    final box = GetStorage();

    log("Menu ID == $id");
    log("new img == $newImagePath");
    log("old img == $oldImagePath");
    log("qty == $qty");
    log("price == $price");

    late Response<dynamic> response;

    try {
      if (newImagePath.isNotEmpty) {
        response = await dio.post(
          menuUrl,
          data: FormData.fromMap(
            {
              'code': code,
              'category_id': categoryId,
              'name': name,
              'description': description,
              'image': await MultipartFile.fromFile(newImagePath),
              'price': price,
              'qty': qty,
              'status': status,
            },
          ),
          options: Options(headers: {
            'Authorization': 'Bearer ${authData.token}',
          }),
        );
      } else {
        response = await dio.post(
          menuUrl,
          data: FormData.fromMap(
            {
              'code': code,
              'category_id': categoryId,
              'name': name,
              'description': description,
              'price': price,
              'qty': qty,
              'status': status,
            },
          ),
          options: Options(headers: {
            'Authorization': 'Bearer ${authData.token}',
          }),
        );
      }

      log("RESPONSE CODE == ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Menu berhasil diperbarui");

        box.remove(currentPathImg);
        return true;
      } else {
        Get.snackbar("Gagal", response.data['message'].toString());
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  static Future<bool> editMenuKitchen(
    int id,
    String code,
    int categoryId,
    String name,
    String description,
    String newImagePath,
    String oldImagePath,
    int price,
    int qty,
    String status,
  ) async {
    final Dio dio = Dio();

    String menuUrl = "$baseUrl${Endpoint.api_menus_id}$id";

    final authData = await AuthProvider.getAuthData();

    final box = GetStorage();

    log("Menu ID == $id");
    log("new img == $newImagePath");
    log("old img == $oldImagePath");
    log("categoryId == $categoryId");
    log("name == $name");
    log("description == $description");
    log("price == $price");
    log("qty == $qty");
    log("status == $status");

    try {
      var response = await dio.post(
        menuUrl,
        data: FormData.fromMap(
          {
            'code': code,
            'category_id': categoryId,
            'name': name,
            'description': description,
            'price': price,
            'qty': qty,
            'status': status,
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.token}',
        }),
      );
      log("RESPONSE CODE == ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Ketersediaan menu berhasil diperbarui");

        box.remove(currentPathImg);
        return true;
      } else {
        Get.snackbar("Gagal", "Ketersediaan menu gagal diperbarui");
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  static Future<bool> deleteMenu(
    int id,
  ) async {
    String menuUrl = "$baseUrl${Endpoint.api_menus_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await http.delete(Uri.parse(menuUrl), headers: {
        'Authorization': 'Bearer ${authData.token}',
      });
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Menu berhasil dihapus");
        Get.back();

        return true;
      } else {
        Get.snackbar("Gagal", "Menu gagal dihapus");
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }
}
