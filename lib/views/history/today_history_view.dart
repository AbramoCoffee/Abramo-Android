import 'dart:developer';

import 'package:abramo_coffee/components/item_history_component.dart';
import 'package:abramo_coffee/controllers/order_item_controller.dart';
import 'package:abramo_coffee/models/orders_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/history/detail_history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayHistoryView extends StatelessWidget {
  const TodayHistoryView({
    super.key,
    // this.isKitchen = false,
    required this.listOrdersModelToday,
  });

  // final bool isKitchen;
  final List<OrdersModel> listOrdersModelToday;

  @override
  Widget build(BuildContext context) {
    final orderItemController = Get.put(OrderItemController());
    log("list Orders Model Today == $listOrdersModelToday");
    return Scaffold(
      backgroundColor: cWhite,
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: listOrdersModelToday.isEmpty
                ? Center(
                    child: Text('Tidak ada riwayat',
                        style: regular.copyWith(
                            fontSize: 15, color: cYellowPrimary)),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: listOrdersModelToday
                          .map((element) => ItemHistoryComponent(
                              status: element.status!,
                              invoiceName: element.invoice!,
                              price: element.totalPrice!,
                              onTap: () async {
                                log("Order ID : ${element.id!}");

                                await orderItemController
                                    .getAllOrderItemByOrder(element.id ?? 1);

                                // print(element.id);
                                Get.to(() => DetailHistoryView(
                                    // isKitchen: isKitchen,
                                    ordersModel: element,
                                    listOrderItemModel: orderItemController
                                        .listOrderItemModel));
                              }))
                          .toList(),
                    ),
                  ),
          )),
    );
  }
}
