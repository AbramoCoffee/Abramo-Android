import 'package:abramo_coffee/models/login_response_model.dart';
import 'package:abramo_coffee/models/user_model.dart';
import 'package:abramo_coffee/providers/auth_provider.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/views/auth/login_view.dart';
import 'package:abramo_coffee/views/bottom_navigation_bar/bottom_navigation_bar_cashier.dart';
import 'package:abramo_coffee/views/bottom_navigation_bar/bottom_navigation_bar_kitchen.dart';
import 'package:abramo_coffee/views/bottom_navigation_bar/bottom_navigation_bar_owner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> roleController = TextEditingController().obs;

  Rx<LoginResponseModel> loginResponseModel = LoginResponseModel().obs;

  RxString role = "".obs;

  RxList<String> listRole = ["kitchen", "cashier"].obs;

  RxList<UserModel> listUserModel = <UserModel>[].obs;

  final formKey = GlobalKey<FormState>().obs;
  RxBool isLoading = false.obs;

  final _box = GetStorage();

  void reset() {
    nameController.value.clear();
    emailController.value.clear();
    passwordController.value.clear();
    roleController.value.clear();
  }

  Future login() async {
    try {
      isLoading.value = true;
      var res = await AuthProvider.login(
        emailController.value.text,
        passwordController.value.text,
      );
      isLoading.value = false;
      AuthProvider.saveAuthData(res);
      loginResponseModel.value = res;
      reset();
      log("Login Response = $res");

      _box.write(uName, res.user!.name);

      _box.write(uEmail, res.user!.email);

      _box.write(uRole, res.user!.role);

      if (res.user!.role == "owner") {
        return Get.offAll(const BottomNavigationBarOwner());
      }

      if (res.user!.role == "cashier") {
        return Get.offAll(const BottomNavigationBarCashier());
      }

      if (res.user!.role == "kitchen") {
        return Get.offAll(const BottomNavigationBarKitchen());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> logout() async {
    try {
      isLoading.value = true;
      var res = await AuthProvider.logout();
      isLoading.value = false;
      AuthProvider.removeAuthData();
      if (res) {
        _box.remove(uName);
        _box.remove(uEmail);
        _box.remove(uRole);
        Get.offAll(const LoginView());
      }
      return res;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> register() async {
    log("=== REGISTER ===");
    log("Name : ${nameController.value.text}");
    log("Email : ${emailController.value.text}");
    log("Password : ${passwordController.value.text}");
    log("Role : ${role.value}");
    log("=== REGISTER ===");

    try {
      isLoading.value = true;
      var res = await AuthProvider.register(
        nameController.value.text,
        emailController.value.text,
        passwordController.value.text,
        role.value,
      );
      isLoading.value = false;
      reset();
      return res;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getAllUser() async {
    try {
      isLoading.value = true;
      log("hehe");
      final listUser = await AuthProvider.getAllUser();
      listUserModel.value = listUser;

      log("List category : $listUserModel");
      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteUser(UserModel userModel) async {
    try {
      isLoading.value = true;
      var res = await AuthProvider.deleteUser(
        userModel.id!,
      );
      isLoading.value = false;

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future saveAuthData(LoginResponseModel loginResponseModel) async {
    try {
      isLoading.value = true;
      await AuthProvider.saveAuthData(loginResponseModel);

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future removeAuthData() async {
    try {
      isLoading.value = true;
      await AuthProvider.removeAuthData();
      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<LoginResponseModel> getAuthData() async {
    try {
      isLoading.value = true;
      var res = await AuthProvider.getAuthData();
      isLoading.value = false;
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> isAuthDataExists() async {
    try {
      isLoading.value = true;
      var res = await AuthProvider.isAuthDataExists();
      isLoading.value = false;
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
