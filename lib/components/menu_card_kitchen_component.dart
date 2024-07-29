import 'dart:developer';

import 'package:abramo_coffee/components/text_field_outlined_component.dart';
import 'package:abramo_coffee/controllers/menus_controller.dart';
import 'package:abramo_coffee/models/menu_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuCardKitchenComponent extends StatelessWidget {
  const MenuCardKitchenComponent(
      {super.key,
      required this.menuModel,
      required this.qtyController,
      required this.onTapEdit});

  final MenuModel menuModel;
  final TextEditingController qtyController;
  final Function() onTapEdit;

  @override
  Widget build(BuildContext context) {
    final menusController = Get.put(MenusController());
    // TextEditingController qtyController = TextEditingController();

    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          border: Border.all(color: cYellowDark),
          borderRadius: BorderRadius.circular(12),
          color: cWhite),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Image.network("$baseUrl${menuModel.image}",
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
            child: Text(
              menuModel.name!,
              style: bold.copyWith(color: cYellowDark, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              "Ketersediaan : ${menuModel.qty!}",
              style: bold.copyWith(color: cYellowDark, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              "Rp. ${menuModel.price!}",
              style: bold.copyWith(color: cYellowPrimary, fontSize: 15),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(2, 5, 2, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextFieldOutlinedComponent(
                        validator: "Ketersediaan harap diisi",
                        hintText: "Ketersediaan",
                        textController: qtyController,
                        keyboardType: TextInputType.number),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: onTapEdit,
                    // () async {
                    // var res = await menusController.editMenuKitchen(MenuModel(
                    //     id: menuModel.id,
                    //     code: menuModel.code,
                    //     categoryId: menuModel.categoryId,
                    //     name: menuModel.name,
                    //     description: menuModel.description,
                    //     image: menuModel.image,
                    //     price: menuModel.price,
                    //     qty: int.parse(
                    //         menusController.qtyController.value.text),
                    //     status: menuModel.status,
                    //     createdAt: menuModel.createdAt,
                    //     updatedAt: menuModel.updatedAt,
                    //     category: menuModel.category));

                    //   log("$res");
                    //   if (res) {
                    //     await menusController.getAllMenu();
                    //   }
                    // },
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
                ],
              ))
        ],
      ),
    );
  }
}
