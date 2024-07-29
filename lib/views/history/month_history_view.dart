import 'dart:developer';

import 'package:abramo_coffee/components/item_history_component.dart';
import 'package:abramo_coffee/controllers/order_item_controller.dart';
import 'package:abramo_coffee/models/orders_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/history/detail_history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthHistoryView extends StatelessWidget {
  const MonthHistoryView({
    super.key,
    // this.isKitchen = false,
    required this.listOrdersModelMonth,
  });

  // final bool isKitchen;
  final List<OrdersModel> listOrdersModelMonth;

  @override
  Widget build(BuildContext context) {
    final orderItemController = Get.put(OrderItemController());

    log("List Orders Model Month == $listOrdersModelMonth");

    return Scaffold(
      backgroundColor: cWhite,
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: listOrdersModelMonth.isEmpty
                ? Center(
                    child: Text('Tidak ada riwayat',
                        style: regular.copyWith(
                            fontSize: 15, color: cYellowPrimary)),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: listOrdersModelMonth
                          .map((element) => ItemHistoryComponent(
                              status: element.status!,
                              invoiceName: element.invoice!,
                              price: element.totalPrice!,
                              onTap: () async {
                                log("Order ID : ${element.id!}");

                                await orderItemController
                                    .getAllOrderItemByOrder(element.id!);

                                // print(element.id);
                                var res = await Get.to(DetailHistoryView(
                                    // isKitchen: isKitchen,
                                    ordersModel: element,
                                    listOrderItemModel: orderItemController
                                        .listOrderItemModel));

                                if (res is bool) {
                                  if (res) {
                                    await orderItemController
                                        .getAllOrderItemByOrder(element.id!);
                                  }
                                }
                              }))
                          .toList(),
                    ),
                  ),
          )),
    );
  }
}
