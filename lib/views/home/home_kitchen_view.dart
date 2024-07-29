import 'dart:developer';

import 'package:abramo_coffee/components/menu_card_component.dart';
import 'package:abramo_coffee/components/menu_card_kitchen_component.dart';
import 'package:abramo_coffee/components/search_field_component.dart';
import 'package:abramo_coffee/controllers/category_controller.dart';
import 'package:abramo_coffee/controllers/menus_controller.dart';
import 'package:abramo_coffee/models/menu_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/home/form_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class HomeKitchenView extends StatelessWidget {
  const HomeKitchenView({super.key});

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
          "Kelola Ketersediaan",
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
                  child: SearchFieldComponent(
                    controller: menusController.searchController.value,
                    hintText: "Cari menu...",
                    icon: Icons.search,
                    onChanged: (value) {
                      menusController.updateSearchQuery(value);
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
                  "Daftar Menu",
                  textAlign: TextAlign.left,
                  style: bold.copyWith(
                    color: cYellowDark,
                    fontSize: 20,
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
                            TextEditingController qtyController =
                                TextEditingController();

                            log("List menu ditampilkan = ${menusController.listMenuModel[index].image}");
                            return MenuCardKitchenComponent(
                                qtyController: qtyController,
                                onTapEdit: () async {
                                  if (qtyController.value.text.isEmpty) {
                                    Get.snackbar("Kesalahan",
                                        "Jumlah ketersediaan harap diisi");
                                  }

                                  if (qtyController.value.text.isNotEmpty) {
                                    var res = await menusController
                                        .editMenuKitchen(MenuModel(
                                            id: menusController
                                                .listMenuModel[index].id,
                                            code: menusController
                                                .listMenuModel[index].code,
                                            categoryId: menusController
                                                .listMenuModel[index]
                                                .categoryId,
                                            name: menusController
                                                .listMenuModel[index].name,
                                            description: menusController
                                                .listMenuModel[index]
                                                .description,
                                            image: menusController
                                                .listMenuModel[index].image,
                                            price: menusController
                                                .listMenuModel[index].price,
                                            qty: int.parse(qtyController.text),
                                            status: menusController
                                                .listMenuModel[index].status,
                                            createdAt: menusController
                                                .listMenuModel[index].createdAt,
                                            updatedAt: menusController
                                                .listMenuModel[index].updatedAt,
                                            category: menusController
                                                .listMenuModel[index]
                                                .category));

                                    if (res) {
                                      await menusController.getAllMenu();
                                    }
                                  }
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
