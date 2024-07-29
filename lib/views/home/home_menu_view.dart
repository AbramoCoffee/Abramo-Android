import 'dart:developer';

import 'package:abramo_coffee/components/menu_card_component.dart';
import 'package:abramo_coffee/components/search_field_component.dart';
import 'package:abramo_coffee/controllers/category_controller.dart';
import 'package:abramo_coffee/controllers/menus_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/home/form_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get_storage/get_storage.dart';

class HomeMenuView extends StatelessWidget {
  const HomeMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final menusController = Get.put(MenusController());
    final categoryController = Get.put(CategoryController());

    menusController.getAllMenu();
    categoryController.getAllCategory();

    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        title: Text(
          "Abramo Coffee",
          style: bold.copyWith(fontSize: 25, color: cWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text("Selamat Datang",
                        style: bold.copyWith(color: cYellowDark, fontSize: 18)),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        var res = await Get.to(FormMenuView(
                            listCategoryModel:
                                categoryController.listCategoryModel));

                        if (res is bool) {
                          if (res) {
                            await menusController.getAllMenu();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: cWhite,
                          foregroundColor: cYellowDark),
                      child: const Text("Tambah"),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SearchFieldComponent(
                    controller: menusController.searchController.value,
                    hintText: "Cari menu...",
                    icon: Icons.search,
                    onChanged: (value) {
                      if (value == "") {
                        menusController.getAllMenu();
                      }
                      if (value != "") {
                        menusController.updateSearchQuery(value);
                      }
                    },
                    // onTap: () {
                    //   menusController.getAllMenu();
                    // },
                  )),
              const SizedBox(height: 20),
              Obx(() => categoryController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(color: cYellowDark),
                    )
                  : categoryController.listCategoryModel.isEmpty
                      ? Center(
                          child: Text("Data tidak ditemukan",
                              style: regular.copyWith(
                                  color: cBlack, fontSize: 20)))
                      : SizedBox(
                          height: 30,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  categoryController.listCategoryModel.length,
                              itemBuilder: (context, index) {
                                final category =
                                    categoryController.listCategoryModel[index];
                                return GestureDetector(
                                  onTap: () {
                                    menusController
                                        .updateSearchCategory(category.id!);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: cWhite,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: cYellowDark)),
                                        child: Text(
                                          "${category.name}",
                                          style: bold.copyWith(
                                            color: menusController
                                                        .selectedCategoryId
                                                        .value ==
                                                    category.id
                                                ? cYellowDark
                                                : cYellowDark,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10)
                                    ],
                                  ),
                                );
                              }),
                        )),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Kelola Daftar Menu",
                  textAlign: TextAlign.left,
                  style: bold.copyWith(
                    color: cYellowDark,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => menusController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(color: cYellowDark),
                    )
                  : menusController.listMenuModel.isEmpty
                      ? Center(
                          child: Text("Data tidak ditemukan",
                              style: regular.copyWith(
                                  color: cBlack, fontSize: 20)))
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: menusController.listMenuModel.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  mainAxisExtent: 260),
                          itemBuilder: (context, index) {
                            log("List menu ditampilkan = ${menusController.listMenuModel[index].image}");
                            return MenuCardComponent(
                                onTapEdit: () async {
                                  menusController.populateFieldWhenEdit(
                                      menusController.listMenuModel[index]);
                                  var res = await Get.to(FormMenuView(
                                      menuModel:
                                          menusController.listMenuModel[index],
                                      isEdit: true,
                                      listCategoryModel: categoryController
                                          .listCategoryModel));

                                  if (res is bool) {
                                    if (res) {
                                      await menusController.getAllMenu();
                                    }
                                  }
                                },
                                onTapDelete: () async {
                                  Navigator.pop(context, true);

                                  await menusController.deleteMenu(
                                      menusController.listMenuModel[index]);
                                  await menusController.getAllMenu();
                                },
                                menuModel:
                                    menusController.listMenuModel[index]);
                          })),
            ],
          ),
        ),
      ),
    );
  }
}
