import 'package:abramo_coffee/components/button_component.dart';
import 'package:abramo_coffee/components/text_field_outlined_component.dart';
import 'package:abramo_coffee/controllers/auth_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        foregroundColor: cWhite,
        title: Text(
          "Tambah Pengguna",
          style: bold.copyWith(fontSize: 25, color: cWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email Pengguna",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Email Pengguna harap diisi",
                    hintText: "Email Pengguna",
                    textController: authController.emailController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Nama Pengguna",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Nama Pengguna harap diisi",
                    hintText: "Nama Pengguna",
                    textController: authController.nameController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Password Pengguna",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Password Pengguna harap diisi",
                    hintText: "Password Pengguna",
                    textController: authController.passwordController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Role Pengguna",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Pilih Role",
                    contentPadding: const EdgeInsets.only(left: 50, right: 16),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
                    fillColor: Colors.black.withOpacity(0.04),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: authController.listRole
                      .map(
                        (element) => DropdownMenuItem(
                          value: element,
                          child: Text(element),
                        ),
                      )
                      .toList(),
                  onChanged: (val) =>
                      authController.role.value = val ?? "cashier",
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 5),
                ButtonComponent(
                  "Tambah Pengguna",
                  onPressed: () async {
                    if (authController.emailController.value.text.isEmpty ||
                        authController.nameController.value.text.isEmpty ||
                        authController.passwordController.value.text.isEmpty ||
                        authController.role.value == "") {
                      Get.snackbar("Kesalahan", "Semua kolom harap diisi");
                    }

                    if (authController.emailController.value.text.isNotEmpty ||
                        authController.nameController.value.text.isNotEmpty ||
                        authController
                            .passwordController.value.text.isNotEmpty ||
                        authController.role.value != "") {
                      var res = await authController.register();

                      authController.emailController.value.clear();
                      authController.nameController.value.clear();
                      authController.passwordController.value.clear();

                      Navigator.pop(context, res);
                    }
                  },
                  color: cYellowDark,
                ),
              ],
            )),
      ),
    );
  }
}
