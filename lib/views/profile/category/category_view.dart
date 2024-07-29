import 'dart:developer';

import 'package:abramo_coffee/components/category_card_component.dart';
import 'package:abramo_coffee/controllers/category_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/profile/category/form_category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    categoryController.getAllCategory();
    // var box = GetStorage();
    // String userName = box.read(uName);

    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        title: Text(
          "Kelola Kategori",
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
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              categoryController.listCategoryModel.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  mainAxisExtent: 260),
                          itemBuilder: (context, index) {
                            log("${categoryController.listCategoryModel[index].image}");
                            return CategoryCardComponent(
                                onTapEdit: () async {
                                  categoryController.populateFieldWhenEdit(
                                      categoryController
                                          .listCategoryModel[index]);
                                  var res = await Get.to(FormCategoryView(
                                      categoryModel: categoryController
                                          .listCategoryModel[index],
                                      isEdit: true));

                                  if (res is bool) {
                                    if (res) {
                                      await categoryController.getAllCategory();
                                    }
                                  }
                                },
                                onTapDelete: () async {
                                  Navigator.pop(context, true);

                                  await categoryController.deleteCategory(
                                      categoryController
                                          .listCategoryModel[index]);
                                  await categoryController.getAllCategory();
                                },
                                categoryModel: categoryController
                                    .listCategoryModel[index]);
                          })),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: cYellowDark,
        padding: const EdgeInsets.all(5),
        height: 80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Obx(() => Row(
                children: [
                  categoryController.listCategoryModel.isNotEmpty
                      ? Text(
                          "Jumlah Kategori : ${categoryController.listCategoryModel.length}",
                          style: bold.copyWith(color: cWhite, fontSize: 15))
                      : Text("Jumlah Kategori : 0",
                          style: bold.copyWith(color: cWhite, fontSize: 15)),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      var res = await Get.to(const FormCategoryView());

                      if (res is bool) {
                        if (res) {
                          await categoryController.getAllCategory();
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
    );
  }
}
