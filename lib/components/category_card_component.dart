import 'package:abramo_coffee/models/category_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCardComponent extends StatelessWidget {
  const CategoryCardComponent(
      {super.key,
      required this.categoryModel,
      required this.onTapEdit,
      required this.onTapDelete});

  final CategoryModel categoryModel;
  final Function() onTapEdit;
  final Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(color: cBlack),
          borderRadius: BorderRadius.circular(12),
          color: cWhite),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Image.network("$baseUrl${categoryModel.image}",
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/placeholder.png",
                  width: 90,
                  height: 80,
                  fit: BoxFit.cover,
                );
              })),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                categoryModel.name!,
                style: bold.copyWith(color: cYellowDark, fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                categoryModel.description!,
                style: regular.copyWith(color: cYellowDark, fontSize: 12),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: onTapEdit,
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(cYellowDark),
                      side: MaterialStatePropertyAll(
                        BorderSide(color: cYellowDark),
                      ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: cYellowDark,
                      size: 20,
                    ),
                  ),
                  OutlinedButton(
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(cYellowDark),
                      side: MaterialStatePropertyAll(
                        BorderSide(color: cYellowDark),
                      ),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: cYellowDark,
                      size: 20,
                    ),
                    onPressed: () {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Konfirmasi Untuk Hapus Data?",
                                    style: TextStyle(
                                      color: cYellowDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Dengan mengkonfirmasi anda mensetujui bahwa anda akan menghapus data tersebut",
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
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
