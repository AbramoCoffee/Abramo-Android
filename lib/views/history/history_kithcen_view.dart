import 'dart:developer';

import 'package:abramo_coffee/components/category_card_component.dart';
import 'package:abramo_coffee/components/item_history_component.dart';
import 'package:abramo_coffee/controllers/order_item_controller.dart';
import 'package:abramo_coffee/controllers/orders_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/history/detail_history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class HistoryKitchenView extends StatelessWidget {
  const HistoryKitchenView({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersController = Get.put(OrdersController());
    // final orderItemController = Get.put(OrderItemController());
    ordersController.getAllOrdersByTime("today");

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
      body: Obx(() => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("Order Masuk Hari Ini",
                      style: bold.copyWith(color: cYellowDark, fontSize: 18)),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ordersController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(color: cYellowDark),
                        )
                      : ordersController.listOrdersModelToday.isEmpty
                          ? Center(
                              child: Text('Tidak ada riwayat',
                                  style: regular.copyWith(
                                      fontSize: 15, color: cYellowPrimary)),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: ordersController.listOrdersModelToday
                                    .map((element) => ItemHistoryComponent(
                                        status: element.status!,
                                        invoiceName: element.invoice!,
                                        price: element.totalPrice!,
                                        onTap: () async {
                                          log("Order ID : ${element.id!}");

                                          // await orderItemController
                                          //     .getAllOrderItemByOrder(
                                          //         element.id ?? 1);

                                          // print(element.id);
                                          var res = await Get.to(
                                              () => DetailHistoryView(
                                                    // isKitchen: isKitchen,
                                                    ordersModel: element,
                                                    idOrder: element.id ?? 1,
                                                    // listOrderItemModel:
                                                    //     orderItemController
                                                    //         .listOrderItemModel
                                                  ));

                                          if (res is bool) {
                                            if (res) {
                                              await ordersController
                                                  .getAllOrdersByTime("today");
                                            }
                                          }
                                        }))
                                    .toList(),
                              ),
                            ),
                ),
              ],
            ),
          )),
    );
  }
}
