import 'package:abramo_coffee/components/search_field_component.dart';
import 'package:abramo_coffee/controllers/cart_controller.dart';
import 'package:abramo_coffee/controllers/category_controller.dart';
import 'package:abramo_coffee/controllers/menus_controller.dart';
import 'package:abramo_coffee/models/cart_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/cart/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final menusController = Get.put(MenusController());
    final cartController = Get.put(CartController());
    final categoryController = Get.put(CategoryController());
    final _box = GetStorage();

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 27),
            child: CircleAvatar(
              backgroundColor: cYellowDark,
              child: IconButton(
                onPressed: () => Get.to(const CartView()),
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: cWhite,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 5),
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
                                  final category = categoryController
                                      .listCategoryModel[index];
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
                                              border: Border.all(
                                                  color: cYellowDark)),
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
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() => menusController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: cYellowDark,
                      ))
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
                              var itemMenu =
                                  menusController.listMenuModel[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(color: cYellowDark),
                                    borderRadius: BorderRadius.circular(12),
                                    color: cWhite),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)),
                                        child: Image.network(
                                            "$baseUrl${itemMenu.image!}",
                                            height: 100,
                                            width: double.infinity,
                                            fit: BoxFit.fill, errorBuilder:
                                                (context, error, stackTrace) {
                                          return Image.asset(
                                            "assets/images/placeholder.png",
                                            width: 90,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          );
                                        })),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        itemMenu.name!,
                                        style: bold.copyWith(
                                            color: cYellowDark, fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "Ketersediaan : ${itemMenu.qty}",
                                        style: bold.copyWith(
                                            color: cYellowPrimary,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "Rp. ${itemMenu.price}",
                                        style: bold.copyWith(
                                            color: cYellowPrimary,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: itemMenu.qty != 0
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  cartController
                                                      .addToCart(CartModel(
                                                          id: itemMenu.id,
                                                          name: itemMenu.name,
                                                          price: itemMenu.price,
                                                          quantity: 1,
                                                          image: itemMenu.image,
                                                          subTotalPerItem:
                                                              itemMenu.price,
                                                          note: ""))
                                                      .then((value) => Get.to(
                                                          CartView(
                                                              qty: itemMenu
                                                                  .qty)));

                                                  _box.write(
                                                      "qtyMenu${itemMenu.id}",
                                                      itemMenu.qty);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: cWhite,
                                                    foregroundColor:
                                                        cYellowDark),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: cYellowDark,
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Center(
                                                  child: Text("Tidak tersedia",
                                                      style: bold.copyWith(
                                                          color: cYellowPrimary,
                                                          fontSize: 15)),
                                                ),
                                              ))
                                  ],
                                ),
                              );
                            })),
              ],
            )),
      ),
    );
  }
}
