// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:abramo_coffee/components/icon_button_component.dart';
import 'package:abramo_coffee/components/item_card_detail_order.dart';
import 'package:abramo_coffee/controllers/order_item_controller.dart';
import 'package:abramo_coffee/controllers/orders_controller.dart';
import 'package:abramo_coffee/models/order_item_model.dart';
import 'package:abramo_coffee/models/orders_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DetailHistoryView extends StatelessWidget {
  const DetailHistoryView({
    super.key,
    // this.isKitchen = true,
    this.ordersModel,
    this.idOrder,
    // required this.listOrderItemModel,
  });

  // final bool isKitchen;
  final OrdersModel? ordersModel;
  final int? idOrder;
  // final List<OrderItemModel> listOrderItemModel;

  @override
  Widget build(BuildContext context) {
    final orderItemController = Get.put(OrderItemController());
    orderItemController.getAllOrderItemByOrder(idOrder!);

    final ordersController = Get.put(OrdersController());

    final _box = GetStorage();

    String userRole = _box.read(uRole);

    // Bluetooth Printer
    BlueThermalPrinter printer = BlueThermalPrinter.instance;

    log("List Order Item Model == ${orderItemController.listOrderItemModel}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        foregroundColor: cWhite,
        title: Text(
          "Detail Order",
          style: bold.copyWith(fontSize: 25, color: cWhite),
        ),
        centerTitle: true,
      ),
      backgroundColor: cWhite,
      body: Obx(() =>
          // oController.isLoading.value
          //     ? const Center(child: CircularProgressIndicator(color: cYellowDark))
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: orderItemController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: cYellowDark),
                  )
                : orderItemController.listOrderItemModel.isEmpty
                    ? Center(
                        child: Text('Tidak ada riwayat',
                            style: regular.copyWith(
                                fontSize: 15, color: cYellowPrimary)),
                      )
                    : SingleChildScrollView(
                        child: orderItemController.listOrderItemModel.isNotEmpty
                            ? Column(
                                children: orderItemController.listOrderItemModel
                                    .map((element) => ItemCardDetailOrder(
                                        orderItemModel: element))
                                    .toList(),
                              )
                            : Container(),
                      ),
          )),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(5),
        height: 200,
        child: ordersModel!.status == "selesai"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Subtotal",
                            textAlign: TextAlign.center,
                            style: bold.copyWith(
                                fontSize: 17, color: cYellowDark)),
                      ),
                      const SizedBox(width: 185),
                      Text(RupiahUtils.beRupiah(ordersModel!.subtotal ?? 0),
                          textAlign: TextAlign.center,
                          style: bold.copyWith(
                              fontSize: 17, color: cYellowPrimary)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("PPN (11%)",
                            textAlign: TextAlign.center,
                            style: bold.copyWith(
                                fontSize: 17, color: cYellowDark)),
                      ),
                      const SizedBox(height: 5),
                      Text(RupiahUtils.beRupiah(ordersModel!.tax ?? 0),
                          textAlign: TextAlign.center,
                          style: bold.copyWith(
                              fontSize: 17, color: cYellowPrimary)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Total",
                            textAlign: TextAlign.center,
                            style: bold.copyWith(
                                fontSize: 17, color: cYellowDark)),
                      ),
                      const SizedBox(height: 5),
                      Text(RupiahUtils.beRupiah(ordersModel!.totalPrice ?? 0),
                          textAlign: TextAlign.center,
                          style: bold.copyWith(
                              fontSize: 17, color: cYellowPrimary)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text("Order telah selesai",
                      style: bold.copyWith(color: cYellowDark, fontSize: 15)),
                  const SizedBox(height: 5),
                  userRole == "cashier"
                      ? IconButtonComponent(
                          title: "Cetak Setruk",
                          color: cYellowDark,
                          icon: const Icon(Icons.print),
                          onPressed: () async {
                            // orderC
                            //     .inputCashController
                            //     .value
                            //     .clear();
                            if ((await printer.isConnected)!) {
                              // SIZE
                              //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                              // ALIGN
                              //0: LEFT, 1:CENTER, 2:RIFGT
                              printer.printNewLine();
                              printer.printCustom("Abramo Coffee", 2, 1);
                              printer.printNewLine();
                              printer.printCustom(
                                  "Jl. Pulasaren No. 102, Cirebon", 1, 1);
                              printer.printNewLine();
                              printer.printCustom(
                                  "Kasir : ${ordersModel!.cashier!}", 1, 1);
                              printer.printNewLine();
                              printer.printCustom(
                                  DateFormat('HH:mm:ss')
                                          .format(DateTime.now()) +
                                      DateFormat(' dd-MM-yyyy HH:mm:ss')
                                          .format(DateTime.now()),
                                  1,
                                  1);
                              printer.printNewLine();
                              printer.printCustom("Pesanan", 1, 1);
                              printer.printNewLine();
                              for (var orderItem
                                  in orderItemController.listOrderItemModel) {
                                printer.printCustom(
                                    orderItem.menu!.name!, 1, 0);
                                printer.printCustom(
                                    "${orderItem.qty!} x " +
                                        RupiahUtils.beRupiah(orderItem.price!) +
                                        "         " +
                                        RupiahUtils.beRupiah(
                                            orderItem.qty! * orderItem.price!),
                                    1,
                                    0);
                              }
                              printer.printNewLine();
                              printer.printCustom(
                                  "Total                  " +
                                      RupiahUtils.beRupiah(
                                          ordersModel!.totalPrice!),
                                  1,
                                  1);
                              printer.printNewLine();
                              printer.printCustom(
                                  "Bayar                  " +
                                      RupiahUtils.beRupiah(
                                          ordersModel!.totalPaid!),
                                  1,
                                  1);
                              printer.printNewLine();
                              printer.printCustom(
                                  "Kembalian              " +
                                      // "1000",
                                      RupiahUtils.beRupiah(
                                          ordersModel!.totalReturn!),
                                  1,
                                  1);
                              printer.printNewLine();
                              printer.printCustom("Terima Kasih", 1, 1);
                              printer.printNewLine();
                              printer.printNewLine();
                              printer.printNewLine();
                            }
                          },
                        )
                      : Container(),
                  const SizedBox(height: 5),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Subtotal",
                            textAlign: TextAlign.center,
                            style: bold.copyWith(
                                fontSize: 17, color: cYellowDark)),
                      ),
                      const SizedBox(width: 185),
                      Text(RupiahUtils.beRupiah(ordersModel!.subtotal ?? 0),
                          textAlign: TextAlign.center,
                          style: bold.copyWith(
                              fontSize: 17, color: cYellowPrimary)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("PPN (11%)",
                            textAlign: TextAlign.center,
                            style: bold.copyWith(
                                fontSize: 17, color: cYellowDark)),
                      ),
                      const SizedBox(height: 5),
                      Text(RupiahUtils.beRupiah(ordersModel!.tax ?? 0),
                          textAlign: TextAlign.center,
                          style: bold.copyWith(
                              fontSize: 17, color: cYellowPrimary)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Total",
                            textAlign: TextAlign.center,
                            style: bold.copyWith(
                                fontSize: 17, color: cYellowDark)),
                      ),
                      const SizedBox(height: 5),
                      Text(RupiahUtils.beRupiah(ordersModel!.totalPrice ?? 0),
                          textAlign: TextAlign.center,
                          style: bold.copyWith(
                              fontSize: 17, color: cYellowPrimary)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text("Order sedang diproses",
                      style: bold.copyWith(color: cYellowDark, fontSize: 15)),
                  const SizedBox(height: 5),
                  userRole == "kitchen"
                      ? ElevatedButton(
                          onPressed: () async {
                            var res =
                                await ordersController.editOrders(ordersModel!);

                            if (res) {
                              Navigator.pop(context, res);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: cWhite,
                              foregroundColor: cYellowDark),
                          child: Text("Selesaikan Order",
                              style: bold.copyWith(
                                  color: cYellowDark, fontSize: 15)),
                        )
                      : Container(),
                  // const SizedBox(height: 10),
                  userRole == "cashier"
                      ? IconButtonComponent(
                          title: "Cetak Setruk",
                          color: cYellowDark,
                          icon: const Icon(Icons.print),
                          onPressed: () async {
                            // orderC
                            //     .inputCashController
                            //     .value
                            //     .clear();
                            if ((await printer.isConnected)!) {
                              // SIZE
                              //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                              // ALIGN
                              //0: LEFT, 1:CENTER, 2:RIFGT
                              printer.printNewLine();
                              printer.printCustom("Abramo Coffee", 2, 1);
                              printer.printNewLine();
                              printer.printCustom(
                                  "Jl. Pulasaren No. 102, Cirebon", 1, 1);
                              printer.printNewLine();
                              printer.printCustom(
                                  "Kasir : ${ordersModel!.cashier!}", 1, 1);
                              printer.printNewLine();
                              printer.printCustom(
                                  DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now()),
                                  1,
                                  1);
                              printer.printNewLine();
                              printer.printCustom("Pesanan", 1, 1);
                              printer.printNewLine();
                              for (var orderItem
                                  in orderItemController.listOrderItemModel) {
                                printer.printCustom(
                                    orderItem.menu!.name!, 1, 0);
                                printer.printCustom(
                                    "${orderItem.qty!} x " +
                                        RupiahUtils.beRupiah(orderItem.price!) +
                                        "         " +
                                        RupiahUtils.beRupiah(
                                            orderItem.qty! * orderItem.price!),
                                    1,
                                    0);
                              }
                              printer.printNewLine();
                              printer.printCustom(
                                  "Total                  " +
                                      RupiahUtils.beRupiah(
                                          ordersModel!.totalPrice!),
                                  1,
                                  1);
                              printer.printNewLine();
                              printer.printCustom(
                                  "Bayar                  " +
                                      RupiahUtils.beRupiah(
                                          ordersModel!.totalPaid!),
                                  1,
                                  1);
                              printer.printNewLine();
                              printer.printCustom(
                                  "Kembalian              " +
                                      // "1000",
                                      RupiahUtils.beRupiah(
                                          ordersModel!.totalReturn!),
                                  1,
                                  1);
                              printer.printNewLine();
                              printer.printCustom("Terima Kasih", 1, 1);
                              printer.printNewLine();
                              printer.printNewLine();
                              printer.printNewLine();
                            }
                          },
                        )
                      : Container()
                ],
              ),
      ),
    );
  }
}
