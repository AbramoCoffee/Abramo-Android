import 'dart:developer';
import 'dart:io';

import 'package:abramo_coffee/components/button_component.dart';
import 'package:abramo_coffee/components/text_field_outlined_component.dart';
import 'package:abramo_coffee/controllers/menus_controller.dart';
import 'package:abramo_coffee/controllers/select_image_controller.dart';
import 'package:abramo_coffee/models/category_model.dart';
import 'package:abramo_coffee/models/menu_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FormMenuView extends StatelessWidget {
  const FormMenuView({
    super.key,
    this.isEdit = false,
    this.menuModel,
    required this.listCategoryModel,
  });

  final bool isEdit;
  final MenuModel? menuModel;
  final List<CategoryModel> listCategoryModel;

  @override
  Widget build(BuildContext context) {
    final menusController = Get.put(MenusController());
    final _box = GetStorage();

    if (isEdit == false) {
      menusController.codeController.value.clear();
      menusController.nameController.value.clear();
      menusController.descriptionController.value.clear();
      menusController.priceController.value.clear();
      menusController.qtyController.value.clear();
    }

    log("List Categoty : ${listCategoryModel[1].name}");
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        foregroundColor: cWhite,
        title: Text(
          isEdit ? "Edit Menu" : "Tambah Menu",
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
                Text("Kode Menu", style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Kode Menu harap diisi",
                    hintText: "Kode Menu",
                    textController: menusController.codeController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                const Text("Kategori Menu",
                    style: TextStyle(color: cDarkYellow)),
                const SizedBox(height: 5),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Pilih Kategori",
                    contentPadding: const EdgeInsets.only(left: 50, right: 16),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
                    fillColor: Colors.black.withOpacity(0.04),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: listCategoryModel
                      .map(
                        (element) => DropdownMenuItem(
                          value: element.id,
                          child: Text(element.name ?? ""),
                        ),
                      )
                      .toList(),
                  onChanged: (val) =>
                      menusController.categoryId.value = val ?? 1,
                ),
                const SizedBox(height: 10),
                Text("Nama Menu", style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Nama Menu harap diisi",
                    hintText: "Nama Menu",
                    textController: menusController.nameController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Deskripsi Menu",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Deskripsi Menu harap diisi",
                    hintText: "Deskripsi Menu",
                    textController: menusController.descriptionController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Harga Menu", style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Harga Menu harap diisi",
                    hintText: "Harga Menu",
                    textController: menusController.priceController.value,
                    keyboardType: TextInputType.number),
                // const SizedBox(height: 10),
                // Text("ketersediaan Menu",
                //     style: regular.copyWith(color: cDarkYellow)),
                // const SizedBox(height: 5),
                // TextFieldOutlinedComponent(
                //     validator: "ketersediaan Menu harap diisi",
                //     hintText: "ketersediaan Menu",
                //     textController: menusController.qtyController.value,
                //     keyboardType: TextInputType.number),
                // const SizedBox(height: 10),
                // const Text("Status Menu", style: TextStyle(color: cDarkYellow)),
                // const SizedBox(height: 5),
                // DropdownButtonFormField(
                //   decoration: InputDecoration(
                //     filled: true,
                //     hintText: "Pilih Status",
                //     contentPadding: const EdgeInsets.only(left: 50, right: 16),
                //     hintStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
                //     fillColor: Colors.black.withOpacity(0.04),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                //   items: menusController.listStatus
                //       .map(
                //         (element) => DropdownMenuItem(
                //           value: element,
                //           child: Text(element),
                //         ),
                //       )
                //       .toList(),
                //   onChanged: (val) =>
                //       menusController.status.value = val ?? "Aktif",
                // ),
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
                                  "$baseUrl${menuModel!.image}",
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
                                    isEdit ? "Edit Menu" : "Tambah Menu",
                                    onPressed: () async {
                                      final imagePath =
                                          _box.read(currentPathImg);

                                      var res = false;
                                      if (isEdit) {
                                        if (menusController.codeController.value.text.isEmpty ||
                                            menusController.nameController.value
                                                .text.isEmpty ||
                                            menusController
                                                .descriptionController
                                                .value
                                                .text
                                                .isEmpty ||
                                            menusController.priceController
                                                .value.text.isEmpty ||
                                            menusController.categoryId.value ==
                                                0) {
                                          Get.snackbar("Kesalahan",
                                              "Semua kolom harap diisi");
                                        }

                                        if (menusController.codeController.value.text.isNotEmpty ||
                                            menusController.nameController.value
                                                .text.isNotEmpty ||
                                            menusController
                                                .descriptionController
                                                .value
                                                .text
                                                .isNotEmpty ||
                                            menusController.priceController
                                                .value.text.isNotEmpty ||
                                            menusController.categoryId.value !=
                                                0) {
                                          res = await menusController
                                              .editMenu(menuModel!);

                                          Navigator.pop(context, res);
                                        }
                                      } else {
                                        if (menusController.codeController.value.text.isEmpty ||
                                            menusController.nameController.value
                                                .text.isEmpty ||
                                            menusController
                                                .descriptionController
                                                .value
                                                .text
                                                .isEmpty ||
                                            menusController.priceController
                                                .value.text.isEmpty ||
                                            menusController.categoryId.value ==
                                                0 ||
                                            imagePath == "") {
                                          Get.snackbar("Kesalahan",
                                              "Semua kolom harap diisi");
                                        }

                                        if (menusController.codeController.value.text.isNotEmpty ||
                                            menusController.nameController.value
                                                .text.isNotEmpty ||
                                            menusController
                                                .descriptionController
                                                .value
                                                .text
                                                .isNotEmpty ||
                                            menusController.priceController
                                                .value.text.isNotEmpty ||
                                            menusController.categoryId.value !=
                                                0 ||
                                            imagePath != "") {
                                          res = await menusController.addMenu();

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
