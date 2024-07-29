import 'dart:convert';
import 'dart:developer';

import 'package:abramo_coffee/models/category_model.dart';
import 'package:abramo_coffee/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import '../resources/constant.dart';
import '../resources/endpoint.dart';

class CategoryProvider {
  static Future<CategoryModel> getCategory(int id) async {
    String categoryUrl = "$baseUrl${Endpoint.api_categories_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await http.get(
        Uri.parse(categoryUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      log("Category Model => ${responseJson['data']}");

      return CategoryModel.fromJson(responseJson['data']);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<CategoryModel>> getAllCategory() async {
    String categoryUrl = baseUrl + Endpoint.api_categories;

    final authData = await AuthProvider.getAuthData();

    List<CategoryModel> listCategoryModel = [];

    try {
      var response = await http.get(
        Uri.parse(categoryUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          CategoryModel categoryModel = CategoryModel.fromJson(data);
          listCategoryModel.add(categoryModel);
        }
      }
      log("List Menu Model => $listCategoryModel");

      return listCategoryModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addCategory(
      String name, String description, String imagePath) async {
    final Dio dio = Dio();

    String menuUrl = baseUrl + Endpoint.api_categories;

    final authData = await AuthProvider.getAuthData();

    final box = GetStorage();

    try {
      var response = await dio.post(
        menuUrl,
        data: FormData.fromMap(
          {
            'name': name,
            'description': description,
            'image': await MultipartFile.fromFile(imagePath),
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.token}',
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());

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

  static Future<bool> editCategory(int id, String name, String description,
      String newImagePath, String oldImagePath) async {
    final Dio dio = Dio();

    String categoryUrl = "$baseUrl${Endpoint.api_categories_id}$id";

    final authData = await AuthProvider.getAuthData();

    final box = GetStorage();

    log("category ID == $id");
    log("new img == $newImagePath");
    log("old img == $oldImagePath");

    late Response<dynamic> response;

    try {
      if (newImagePath.isNotEmpty) {
        response = await dio.post(
          categoryUrl,
          data: FormData.fromMap(
            {
              'name': name,
              'description': description,
              'image': await MultipartFile.fromFile(newImagePath)
            },
          ),
          options: Options(headers: {
            'Authorization': 'Bearer ${authData.token}',
          }),
        );
      } else {
        response = await dio.post(
          categoryUrl,
          data: FormData.fromMap(
            {
              'name': name,
              'description': description,
            },
          ),
          options: Options(headers: {
            'Authorization': 'Bearer ${authData.token}',
          }),
        );
      }

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());

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

  static Future<bool> deleteCategory(
    int id,
  ) async {
    String categoryUrl = "$baseUrl${Endpoint.api_categories_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await http.delete(Uri.parse(categoryUrl), headers: {
        'Authorization': 'Bearer ${authData.token}',
      });
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Category berhasil dihapus");
        Get.back();

        return true;
      } else {
        Get.snackbar("Gagal", "Category gagal dihapus");
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }
}
