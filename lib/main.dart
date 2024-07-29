import 'dart:developer';

import 'package:abramo_coffee/controllers/auth_controller.dart';
import 'package:abramo_coffee/models/login_response_model.dart';
import 'package:abramo_coffee/views/auth/login_view.dart';
import 'package:abramo_coffee/views/bottom_navigation_bar/bottom_navigation_bar_cashier.dart';
import 'package:abramo_coffee/views/bottom_navigation_bar/bottom_navigation_bar_kitchen.dart';
import 'package:abramo_coffee/views/bottom_navigation_bar/bottom_navigation_bar_owner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Future.delayed(const Duration(seconds: 3));
  // FlutterNativeSplash.remove();
  await GetStorage.init();

  runApp(const MyApp());
  initializeDateFormatting();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
          future: authController.isAuthDataExists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.hasData == true) {
              log("Has Data Auth");
              if (snapshot.data == true) {
                return FutureBuilder<LoginResponseModel>(
                    future: authController.getAuthData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (snapshot.hasData == true) {
                        log("Has snapshot Data Auth  = ${snapshot.hasData}");
                        if (snapshot.data != null) {
                          // authController.removeAuthData();
                          log("User Login : ${snapshot.data!.user!}");
                          return homeViewPerRole(snapshot.data!.user!.role);
                        } else {
                          return const LoginView();
                        }
                      }
                      return const Scaffold(
                        body: Center(
                          child: Text('Error'),
                        ),
                      );
                    });
              } else {
                return const LoginView();
              }
            }
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          }),
    );
  }

  homeViewPerRole(role) {
    switch (role) {
      case "owner":
        return const BottomNavigationBarOwner();
      case "cashier":
        return const BottomNavigationBarCashier();
      case "kitchen":
        return const BottomNavigationBarKitchen();
      default:
        break;
    }
  }
}
