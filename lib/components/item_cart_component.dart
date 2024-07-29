// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:abramo_coffee/controllers/cart_controller.dart';
import 'package:abramo_coffee/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:get/get.dart';

class ItemCartComponent extends StatelessWidget {
  const ItemCartComponent({
    Key? key,
    required this.cartModel,
    required this.itemQuantity,
  }) : super(key: key);

  final CartModel cartModel;
  final int itemQuantity;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return SizedBox(
      height: 110,
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
                Image.network(
                  "$baseUrl${cartModel.image!}",
                  // "https://picsum.photos/id/1/200/300",
                  width: 90,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/placeholder.png",
                      width: 90,
                      height: 80,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cartModel.name!,
                        style: bold.copyWith(color: cYellowDark, fontSize: 18),
                      ),
                      Text(
                        RupiahUtils.beRupiah(cartModel.subTotalPerItem!),
                        style:
                            bold.copyWith(color: cYellowPrimary, fontSize: 15),
                      ),
                      Row(children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.remove,
                            color: cYellowDark,
                          ),
                          onTap: () {
                            itemQuantity == 1
                                ? cartController.deleteCartItem(cartModel.id!)
                                : cartController.decreaseQuantity(cartModel);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(itemQuantity.toString()),
                        ),
                        GestureDetector(
                            child: const Icon(
                              Icons.add,
                              color: cYellowDark,
                            ),
                            onTap: () {
                              cartController.increaseQuantity(cartModel);
                            }),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
                icon: const Icon(Icons.delete_outline, color: cYellowDark),
                onPressed: () {
                  cartController.deleteCartItem(cartModel.id!);
                  itemQuantity == 1
                      ? cartController.deleteCartItem(cartModel.id!)
                      : cartController.decreaseQuantity(cartModel);
                }),
          ],
        )),
      ),
    );
  }
}
