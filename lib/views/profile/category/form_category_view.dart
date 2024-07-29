import 'dart:io';

import 'package:abramo_coffee/components/button_component.dart';
import 'package:abramo_coffee/components/text_field_outlined_component.dart';
import 'package:abramo_coffee/controllers/category_controller.dart';
import 'package:abramo_coffee/controllers/select_image_controller.dart';
import 'package:abramo_coffee/models/category_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FormCategoryView extends StatelessWidget {
  const FormCategoryView({
    super.key,
    this.isEdit = false,
    this.categoryModel,
  });

  final bool isEdit;
  final CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final _box = GetStorage();

    if (isEdit == false) {
      categoryController.nameController.value.clear();
      categoryController.descriptionController.value.clear();
    }
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        foregroundColor: cWhite,
        title: Text(
          isEdit ? "Edit Kategori" : "Tambah Kategori",
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
                Text("Nama Kategori",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Nama kategori harap diisi",
                    hintText: "Nama kategori",
                    textController: categoryController.nameController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Deskripsi Kategori",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Deskripsi kategori harap diisi",
                    hintText: "Deskripsi kategori",
                    textController:
                        categoryController.descriptionController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Gambar", style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                GetX<SelectImageController>(
                  init: SelectImageController(),
                  builder: (imageController) => Column(
                    children: [
                      InkWell(
                        onTap: () => imageController.selectImage(),
                        child: isEdit && imageController.path.value == 'Pilih'
                            ? Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(color: cYellowDark),
                                ),
                                child: Image.network(
                                  "$baseUrl${categoryModel!.image}",
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                          'assets/images/placeholder.png'),
                                ),
                              )
                            : SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: imageController.path.value != 'Pilih'
                                      ? Image.file(
                                          File(imageController.path.value))
                                      : const Center(
                                          child: Text(
                                            "Upload foto Pengajuan",
                                            style:
                                                TextStyle(color: cYellowDark),
                                          ),
                                        ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    !isEdit
                                        ? "Pilih File yang cocok untuk pengiriman data yang harus anda kirimkan"
                                        : "Klik gambar di atas untuk mengupload ulang gambar baru",
                                    textAlign: TextAlign.center,
                                  ),
                                  ButtonComponent(
                                    isEdit
                                        ? "Edit Kategori"
                                        : "Tambah Kategori",
                                    onPressed: () async {
                                      final imagePath =
                                          _box.read(currentPathImg);
                                      var res = false;
                                      if (isEdit) {
                                        if (categoryController.nameController
                                                .value.text.isEmpty ||
                                            categoryController
                                                .descriptionController
                                                .value
                                                .text
                                                .isEmpty) {
                                          Get.snackbar("Kesalahan",
                                              "Semua kolom harap diisi");
                                        }

                                        if (categoryController.nameController
                                                .value.text.isNotEmpty ||
                                            categoryController
                                                .descriptionController
                                                .value
                                                .text
                                                .isNotEmpty) {
                                          res = await categoryController
                                              .editCategory(categoryModel!);

                                          Navigator.pop(context, res);
                                        }
                                      } else {
                                        if (categoryController.nameController
                                                .value.text.isEmpty ||
                                            categoryController
                                                .descriptionController
                                                .value
                                                .text
                                                .isEmpty ||
                                            imagePath == "") {
                                          Get.snackbar("Kesalahan",
                                              "Semua kolom harap diisi");
                                        }

                                        if (categoryController.nameController
                                                .value.text.isNotEmpty ||
                                            categoryController
                                                .descriptionController
                                                .value
                                                .text
                                                .isNotEmpty ||
                                            imagePath != "") {
                                          res = await categoryController
                                              .addCategory();

                                          Navigator.pop(context, res);
                                        }
                                      }
                                    },
                                    color: cYellowDark,
                                  ),
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
