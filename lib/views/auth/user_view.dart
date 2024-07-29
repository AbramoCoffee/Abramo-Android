import 'package:abramo_coffee/components/item_user_component.dart';
import 'package:abramo_coffee/controllers/auth_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/auth/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    authController.getAllUser();
    // var box = GetStorage();
    // String userName = box.read(uName);

    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        title: Text(
          "Kelola Pengguna",
          style: bold.copyWith(fontSize: 25, color: cWhite),
        ),
        centerTitle: true,
      ),
      body: Obx(() => authController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: cYellowDark,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: authController.listUserModel.isEmpty
                  ? const Center(
                      child: Text('Tidak ada Laporan'),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: authController.listUserModel.length,
                      itemBuilder: (context, index) {
                        return ItemUserComponent(
                            onTapDelete: () async {
                              Navigator.pop(context, true);

                              await authController.deleteUser(
                                  authController.listUserModel[index]);
                              await authController.getAllUser();
                            },
                            userModel: authController.listUserModel[index]);
                      }))),
      bottomNavigationBar: BottomAppBar(
        color: cYellowDark,
        padding: const EdgeInsets.all(5),
        height: 80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Obx(() => Row(
                children: [
                  authController.listUserModel.isNotEmpty
                      ? Text(
                          "Jumlah Pengguna : ${authController.listUserModel.length}",
                          style: bold.copyWith(color: cWhite, fontSize: 15))
                      : Text("Jumlah Pengguna : 0",
                          style: bold.copyWith(color: cWhite, fontSize: 15)),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      var res = await Get.to(const RegisterView());

                      if (res is bool) {
                        if (res) {
                          await authController.getAllUser();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: cWhite, foregroundColor: cYellowDark),
                    child: const Text("Tambah"),
                  )
                ],
              )),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 30, right: 30),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(top: 20),
      //           child: Row(
      //             children: [
      // Text("Daftar Pengguna",
      //     style: bold.copyWith(color: cYellowDark, fontSize: 15)),
      // const Spacer(),
      // ElevatedButton(
      //   onPressed: () async {
      //     var res = await Get.to(const RegisterView());

      //     if (res is bool) {
      //       if (res) {
      //         await authController.getAllUser();
      //       }
      //     }
      //   },
      //   style: ElevatedButton.styleFrom(
      //       backgroundColor: cWhite,
      //       foregroundColor: cYellowDark),
      //   child: const Text("Tambah"),
      // )
      //             ],
      //           ),
      //         ),
      //         const SizedBox(height: 10),
      //         Obx(() => authController.isLoading.value
      //             ? const Center(
      //                 child: CircularProgressIndicator(color: cYellowDark),
      //               )
      //             : authController.listUserModel.isEmpty
      //                 ? Center(
      //                     child: Text("Data tidak ditemukan",
      //                         style: regular.copyWith(
      //                             color: cBlack, fontSize: 20)))
      //                 : ListView.builder(
      //                     scrollDirection: Axis.vertical,
      //                     itemCount: authController.listUserModel.length,
      //                     itemBuilder: (context, index) {
      //                       return ItemUserComponent(
      //                           onTapDelete: () async {
      //                             Navigator.pop(context, true);

      //                             await authController.deleteUser(
      //                                 authController.listUserModel[index]);
      //                             await authController.getAllUser();
      //                           },
      //                           userModel: authController.listUserModel[index]);
      //                     })),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
