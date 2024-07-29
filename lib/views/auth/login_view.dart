import 'dart:developer';

import 'package:abramo_coffee/components/button_component.dart';
import 'package:abramo_coffee/components/text_field_component.dart';
import 'package:abramo_coffee/controllers/auth_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: cWhite,
      body: Center(
        child: Form(
          key: authController.formKey.value,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // const Text(
                  //   'Login',
                  //   style: TextStyle(
                  //     color: cYellowDark,
                  //     fontSize: 32,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  Image.asset(
                    'assets/images/logo.jpg',
                    width: 300,
                    height: 250,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email",
                                style: regular.copyWith(
                                    fontSize: 12, color: cYellowDark)),
                            const SizedBox(height: 5),
                            TextFieldComponent(
                                // validator: "Email harap diisi",
                                controller:
                                    authController.emailController.value,
                                hintText: "Email",
                                icon: Icons.person,
                                obsecureText: false,
                                keyboarType: TextInputType.emailAddress),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Password",
                                style: regular.copyWith(
                                    fontSize: 12, color: cYellowDark)),
                            const SizedBox(height: 5),
                            TextFieldComponent(
                                // validator: "password harap diisi",
                                controller:
                                    authController.passwordController.value,
                                hintText: "Password",
                                icon: Icons.lock,
                                obsecureText: true,
                                keyboarType: TextInputType.visiblePassword),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ButtonComponent(
                          "Login",
                          onPressed: () {
                            if (authController
                                    .emailController.value.text.isEmpty ||
                                authController
                                    .passwordController.value.text.isEmpty) {
                              Get.snackbar(
                                  "Kesalahan", "Semua kolom harap diisi");
                            }

                            if (authController
                                    .emailController.value.text.isNotEmpty ||
                                authController
                                    .passwordController.value.text.isNotEmpty) {
                              authController.formKey.value.currentState!
                                      .validate()
                                  ? authController.login()
                                  : null;
                            }
                            log("On Tap Login");
                          },
                          color: cYellowDark,
                        ),
                        // ElevatedButton(
                        //   child: Text("Login"),
                        //   onPressed: () {
                        //     // Get.offAll(const BottomNavBarOwner());
                        //     controller.formKey.value.currentState!.validate()
                        //         ? controller.loginUser()
                        //         : null;
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //       backgroundColor: cWhite,
                        //       foregroundColor: cYellowDark),
                        // ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
