import 'dart:developer';

import 'package:abramo_coffee/components/menu_profile_component.dart';
import 'package:abramo_coffee/controllers/auth_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/auth/user_view.dart';
import 'package:abramo_coffee/views/profile/category/category_view.dart';
import 'package:abramo_coffee/views/profile/profile_setting_printer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    final _box = GetStorage();

    String userName = _box.read(uName);
    String userEmail = _box.read(uEmail);
    String userRole = _box.read(uRole);

    log("name : $userName");
    log("role : $userRole");

    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        title: Text(
          "Profile",
          style: bold.copyWith(fontSize: 25, color: cWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                  width: 32,
                  child: CircleAvatar(
                    // backgroundImage: Image.network("$baseUrl${authController.loginResponseModel.value.user.email}",
                    //     width: double.infinity, height: 100, fit: BoxFit.fill,
                    //     errorBuilder: (context, error, stackTrace) {
                    //   return Image.asset(
                    //     "assets/images/placeholder.png",
                    //     width: 90,
                    //     height: 80,
                    //     fit: BoxFit.cover,
                    //   );
                    // }),
                    backgroundImage: NetworkImage(
                      "https://www.w3schools.com/w3images/avatar2.png",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(userName,
                      // "${authController.loginResponseModel.value.user!.name}",
                      // userName ?? "Admin",
                      style: bold.copyWith(color: cYellowDark, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(userEmail,
                      // "${authController.loginResponseModel.value.user!.email}",
                      // userEmail ?? "admin@gmail.com",
                      style: bold.copyWith(color: cYellowDark, fontSize: 15)),
                ),
                userRole == "owner"
                    ? Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: MenuProfileComponent(
                                  onTap: () {
                                    Get.to(const UserView());
                                  },
                                  icon: Icons.person,
                                  name: "Kelola Pengguna")),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: MenuProfileComponent(
                                  onTap: () {
                                    Get.to(const CategoryView());
                                  },
                                  icon: Icons.category,
                                  name: "Kelola Kategori"))
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container()),
                userRole == "cashier"
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MenuProfileComponent(
                            onTap: () {
                              Get.to(ProfileSettingPrinterView());
                            },
                            icon: Icons.print,
                            name: "Kelola Printer"))
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container()),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: MenuProfileComponent(
                        onTap: () {
                          Get.dialog(
                            Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: 350,
                                height: 180,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Konfirmasi untuk keluar?",
                                        style: TextStyle(
                                          color: cYellowDark,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Dengan mengkonfirmasi anda mensetujui bahwa anda akan log out dari akun yang sekarang anda gunakan",
                                        style: TextStyle(
                                          color: Color(0xff808D9D),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: const ButtonStyle(
                                              elevation:
                                                  MaterialStatePropertyAll(0),
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(
                                                cYellowDark,
                                              ),
                                            ),
                                            onPressed: () =>
                                                authController.logout(),
                                            child: const Text("Konfirmasi"),
                                          ),
                                          OutlinedButton(
                                            onPressed: () => Get.back(),
                                            style: const ButtonStyle(
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      cYellowDark),
                                              side: MaterialStatePropertyAll(
                                                BorderSide(color: cYellowDark),
                                              ),
                                            ),
                                            child: const Text("Batalkan"),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          );
                        },
                        icon: Icons.logout,
                        name: "Keluar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
