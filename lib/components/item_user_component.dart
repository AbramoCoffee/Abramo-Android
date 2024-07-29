// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:abramo_coffee/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:get/get.dart';

class ItemUserComponent extends StatelessWidget {
  const ItemUserComponent({
    Key? key,
    required this.userModel,
    required this.onTapDelete,
  }) : super(key: key);

  final UserModel userModel;
  final Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 2,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email : ${userModel.email!}",
                        style: bold.copyWith(color: cYellowDark, fontSize: 15),
                      ),
                      Text(
                        "Nama : ${userModel.name!}",
                        style: bold.copyWith(color: cYellowDark, fontSize: 15),
                      ),
                      Text(
                        "Role : ${userModel.role!}",
                        style: bold.copyWith(color: cYellowDark, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
                icon: const Icon(Icons.delete_outline, color: cYellowDark),
                onPressed: () {
                  Get.dialog(
                    Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: 350,
                        height: 170,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Konfirmasi Untuk Hapus Pengguna?",
                                style: TextStyle(
                                  color: cYellowDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Dengan mengkonfirmasi anda mensetujui bahwa anda akan menghapus pengguna tersebut",
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
                                      elevation: MaterialStatePropertyAll(0),
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                        cYellowDark,
                                      ),
                                    ),
                                    onPressed: onTapDelete,
                                    child: const Text("Konfirmasi"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () => Get.back(),
                                    style: const ButtonStyle(
                                      foregroundColor:
                                          MaterialStatePropertyAll(cYellowDark),
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
                }),
          ],
        )),
      ),
    );
  }
}
