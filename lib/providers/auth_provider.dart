import 'dart:convert';
import 'dart:developer';
import 'package:abramo_coffee/models/login_response_model.dart';
import 'package:abramo_coffee/models/user_model.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/endpoint.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  static Future<LoginResponseModel> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl${Endpoint.auth_login}');

      log("URL : $url");
      log("EMAIL : $email");
      log("Password : $password");

      http.Response response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      log("Response : ${response.body}");
      log("Status Code : ${response.statusCode}");

      if (response.statusCode != 200) {
        return Future.error(Exception("Login Failed"));
      }

      Map<String, dynamic> data = jsonDecode(response.body);

      return LoginResponseModel.fromJson(data);
    } catch (e) {
      log("Error : $e");
      throw Exception(e);
    }
  }

  static Future<bool> logout() async {
    try {
      final authData = await getAuthData();

      String url = baseUrl + Endpoint.auth_logout;

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          // 'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        return Future.error(Exception("Logout Failed"));
      }

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> register(
      String name, String email, String password, String role) async {
    try {
      final authData = await getAuthData();

      String url = baseUrl + Endpoint.auth_register;

      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'password': password,
          'name': name,
          'role': role,
        },
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        return Future.error(Exception("Register failed"));
      }

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<UserModel>> getAllUser() async {
    String userUrl = baseUrl + Endpoint.api_users;

    final authData = await AuthProvider.getAuthData();

    List<UserModel> listUserModel = [];

    try {
      var response = await http.get(
        Uri.parse(userUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          UserModel userModel = UserModel.fromJson(data);
          listUserModel.add(userModel);
        }
      }
      log("List User Model => $listUserModel");

      return listUserModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> deleteUser(
    int id,
  ) async {
    String userUrl = "$baseUrl${Endpoint.api_users_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await http.delete(Uri.parse(userUrl), headers: {
        'Authorization': 'Bearer ${authData.token}',
      });
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "User berhasil dihapus");
        Get.back();

        return true;
      } else {
        Get.snackbar("Gagal", "User gagal dihapus");
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  static Future<void> saveAuthData(
      LoginResponseModel loginResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', jsonEncode(loginResponseModel));
  }

  static Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  static Future<LoginResponseModel> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');

    log("AutData == $authData");

    return LoginResponseModel.fromJson(jsonDecode(authData!));
  }

  static Future<bool> isAuthDataExists() async {
    final prefs = await SharedPreferences.getInstance();

    log("isAuthDataExists = ${prefs.containsKey('auth_data')}");
    return prefs.containsKey('auth_data');
  }
}
