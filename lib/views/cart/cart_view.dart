import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:abramo_coffee/components/icon_button_component.dart';
import 'package:abramo_coffee/components/item_cart_component.dart';
import 'package:abramo_coffee/components/text_field_outlined_component.dart';
import 'package:abramo_coffee/controllers/cart_controller.dart';
import 'package:abramo_coffee/controllers/menus_controller.dart';
import 'package:abramo_coffee/controllers/orders_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:abramo_coffee/resources/constant.dart';
// import 'package:flutter_file_downloader/flutter_file_downloader.dart';
// import 'package:screenshot/screenshot.dart';

class CartView extends StatefulWidget {
  const CartView({super.key, this.qty});

  final int? qty;

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  Uint8List? bytes;

  // Bluetooth Printer
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  Widget build(BuildContext context) {
    // final appDocumentsDire = getApplicationDocumentsDirectory();
    final cartController = Get.put(CartController());
    final ordersController = Get.put(OrdersController());
    final menusController = Get.put(MenusController());
    final _box = GetStorage();

    List<int> listQtyMenu = [];

    listQtyMenu.add(widget.qty ?? 0);
    log("listQtyMenu $listQtyMenu");
    String userName = _box.read(uName);
    cartController.getCartItems();
    cartController.getItemSubtotal();
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        foregroundColor: cWhite,
        title: Text(
          "Keranjang",
          style: bold.copyWith(fontSize: 25, color: cWhite),
        ),
        centerTitle: true,
      ),
      body: Obx(() => cartController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: cYellowDark,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: cartController.cartItems.isEmpty
                  ? const Center(
                      child: Text('Tidak ada data'),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        var itemCart = cartController.cartItems[index];
                        return ItemCartComponent(
                          cartModel: itemCart,
                          itemQuantity: itemCart.quantity!,
                        );
                      }))),
      bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(10),
          height: 170,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Total",
                    textAlign: TextAlign.center,
                    style: bold.copyWith(fontSize: 20, color: cYellowDark)),
                const SizedBox(height: 5),
                Text(RupiahUtils.beRupiah(cartController.subtotal.toInt()),
                    textAlign: TextAlign.center,
                    style: bold.copyWith(fontSize: 17, color: cYellowPrimary)),
                const SizedBox(height: 10),
                Text("Pilih Pembayaran",
                    textAlign: TextAlign.center,
                    style: bold.copyWith(fontSize: 20, color: cYellowDark)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButtonComponent(
                      title: "Tunai",
                      onPressed: () {
                        // orderC.addOrders();
                        Get.dialog(Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 350,
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Pembayaran Tunai",
                                    style: bold.copyWith(
                                        fontSize: 20, color: cYellowDark)),
                                const SizedBox(height: 15),
                                TextFieldOutlinedComponent(
                                    validator: "Nama konsumen harap diisi",
                                    hintText: "Nama Konsumen",
                                    textController: ordersController
                                        .customerNameController.value,
                                    keyboardType: TextInputType.text),
                                const SizedBox(height: 8),
                                TextFieldOutlinedComponent(
                                    validator: "Uang diterima harap diisi",
                                    hintText: "Uang diterima",
                                    textController: ordersController
                                        .inputCashController.value,
                                    keyboardType: TextInputType.number),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        Get.back();
                                        ordersController
                                            .customerNameController.value
                                            .clear();
                                        ordersController
                                            .inputCashController.value
                                            .clear();
                                      },
                                      style: const ButtonStyle(
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                cYellowDark),
                                        side: MaterialStatePropertyAll(
                                          BorderSide(color: cYellowDark),
                                        ),
                                      ),
                                      child: Text("Batal",
                                          style: regular.copyWith(
                                              fontSize: 15,
                                              color: cYellowDark)),
                                    ),
                                    const SizedBox(width: 10),
                                    OutlinedButton(
                                      style: const ButtonStyle(
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                cYellowDark),
                                        side: MaterialStatePropertyAll(
                                          BorderSide(color: cYellowDark),
                                        ),
                                      ),
                                      child: Text("Proses",
                                          style: regular.copyWith(
                                              fontSize: 15,
                                              color: cYellowDark)),
                                      onPressed: () async {
                                        log("cartItem qty : ${cartController.cartItems}");

                                        // if (cartController
                                        //     .cartItems.isNotEmpty) {
                                        //   log("cartController12321");

                                        //   for (var item
                                        //       in cartController.cartItems) {
                                        //     // log("cartController");
                                        //     var menuQty =
                                        //         _box.read("qtyMenu${item.id}");

                                        //     log("cartController : $menuQty");
                                        //     log("cartController : $item");

                                        //     // if (item.quantity! > menuQty) {
                                        //     //   Get.back();

                                        //     //   Get.snackbar("Kesalahan",
                                        //     //       "Tidak dapat memproses order, jumlah melebihi ketersediaan menu");
                                        //     // }
                                        //   }
                                        // }

                                        if (cartController.cartItems.isEmpty) {
                                          Get.back();

                                          Get.snackbar("Kesalahan",
                                              "Tidak dapat memproses order, data keranjang tidak ada");
                                        }

                                        if (ordersController.inputCashController
                                            .value.text.isEmpty) {
                                          ordersController
                                              .customerNameController.value
                                              .clear();
                                          ordersController
                                              .inputCashController.value
                                              .clear();
                                          Get.back();

                                          Get.snackbar("Kesalahan",
                                              "Harap masukkan nilai pembayaran");
                                        }

                                        if (ordersController
                                            .customerNameController
                                            .value
                                            .text
                                            .isEmpty) {
                                          ordersController
                                              .customerNameController.value
                                              .clear();
                                          ordersController
                                              .inputCashController.value
                                              .clear();

                                          Get.back();

                                          Get.snackbar("Kesalahan",
                                              "Harap masukkan nama customer");
                                        }

                                        if (int.parse(ordersController
                                                .inputCashController
                                                .value
                                                .text) <
                                            cartController.subtotal.toInt()) {
                                          ordersController
                                              .customerNameController.value
                                              .clear();
                                          ordersController
                                              .inputCashController.value
                                              .clear();

                                          Get.back();

                                          Get.snackbar("Kesalahan",
                                              "Uang diterima tidak mencukupi");
                                        }

                                        if (ordersController.inputCashController.value.text.isNotEmpty &&
                                            ordersController
                                                .customerNameController
                                                .value
                                                .text
                                                .isNotEmpty &&
                                            int.parse(ordersController
                                                    .inputCashController
                                                    .value
                                                    .text) >=
                                                cartController.subtotal
                                                    .toInt()) {
                                          await ordersController.addOrders(
                                              ordersController
                                                  .customerNameController
                                                  .value
                                                  .text,
                                              userName,
                                              "Tunai",
                                              int.parse(ordersController
                                                  .inputCashController
                                                  .value
                                                  .text),
                                              cartController.cartItems);

                                          // Get.snackbar("Test", "TEST");
                                          Navigator.pop(context, true);

                                          Get.dialog(
                                            Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                width: 350,
                                                height: 450,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                          "Pembayaran Berhasil",
                                                          style: bold.copyWith(
                                                              fontSize: 20,
                                                              color:
                                                                  cYellowDark)),
                                                    ),
                                                    const SizedBox(height: 30),
                                                    Text("Metode Pembayaran",
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowDark)),
                                                    const SizedBox(height: 10),
                                                    Text("Tunai",
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowPrimary)),
                                                    const SizedBox(height: 15),
                                                    Text("Total Pembelian",
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowDark)),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                        RupiahUtils.beRupiah(
                                                            cartController
                                                                .subtotal
                                                                .toInt()),
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowPrimary)),
                                                    const SizedBox(height: 15),
                                                    Text("Nominal Bayar",
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowDark)),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                        RupiahUtils.beRupiah(int
                                                            .parse(ordersController
                                                                .inputCashController
                                                                .value
                                                                .text)),
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowPrimary)),
                                                    const SizedBox(height: 15),
                                                    Text("Kembalian",
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowDark)),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                        RupiahUtils.beRupiah(
                                                            int.parse(ordersController
                                                                    .inputCashController
                                                                    .value
                                                                    .text) -
                                                                cartController
                                                                    .subtotal
                                                                    .toInt()),
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowPrimary)),
                                                    const SizedBox(height: 15),
                                                    Text("Waktu Pembayaran",
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowDark)),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                        DateFormat('HH:mm:ss')
                                                                .format(DateTime
                                                                    .now()) +
                                                            DateFormat(
                                                                    'dd-MM-yyyy')
                                                                .format(DateTime
                                                                    .now()),
                                                        style: bold.copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                cYellowPrimary)),
                                                    const SizedBox(height: 25),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        OutlinedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, true);
                                                            cartController
                                                                .setSubtotalDefault();
                                                            ordersController
                                                                .customerNameController
                                                                .value
                                                                .clear();
                                                            ordersController
                                                                .inputCashController
                                                                .value
                                                                .clear();
                                                            cartController
                                                                .deleteAllData();
                                                            menusController
                                                                .getAllMenu();
                                                          },
                                                          style:
                                                              const ButtonStyle(
                                                            foregroundColor:
                                                                MaterialStatePropertyAll(
                                                                    cYellowDark),
                                                            side:
                                                                MaterialStatePropertyAll(
                                                              BorderSide(
                                                                  color:
                                                                      cYellowDark),
                                                            ),
                                                          ),
                                                          child: Text("Selesai",
                                                              style: regular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      color:
                                                                          cYellowDark)),
                                                        ),
                                                        OutlinedButton(
                                                          onPressed: () async {
                                                            // SIZE
                                                            //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                                                            // ALIGN
                                                            //0: LEFT, 1:CENTER, 2:RIFGT
                                                            if ((await printer
                                                                .isConnected)!) {
                                                              printer
                                                                  .printNewLine();
                                                              printer.printCustom(
                                                                  "Abramo Coffee",
                                                                  2,
                                                                  1);
                                                              printer
                                                                  .printNewLine();
                                                              printer.printCustom(
                                                                  "Jl. Pulasaren No. 102, Cirebon",
                                                                  1,
                                                                  1);
                                                              printer
                                                                  .printNewLine();
                                                              printer.printCustom(
                                                                  "Kasir : $userName",
                                                                  1,
                                                                  1);
                                                              printer
                                                                  .printNewLine();
                                                              printer.printCustom(
                                                                  DateFormat('HH:mm:ss').format(
                                                                          DateTime
                                                                              .now()) +
                                                                      DateFormat(
                                                                              'dd-MM-yyyy')
                                                                          .format(
                                                                              DateTime.now()),
                                                                  1,
                                                                  1);
                                                              printer
                                                                  .printNewLine();
                                                              printer
                                                                  .printCustom(
                                                                      "Pesanan",
                                                                      1,
                                                                      1);
                                                              printer
                                                                  .printNewLine();
                                                              for (var cartItem
                                                                  in cartController
                                                                      .cartItems) {
                                                                printer.printCustom(
                                                                    cartItem
                                                                        .name!,
                                                                    1,
                                                                    0);
                                                                printer.printCustom(
                                                                    "${cartItem.quantity!} x " +
                                                                        RupiahUtils.beRupiah(cartItem
                                                                            .price!) +
                                                                        "         " +
                                                                        RupiahUtils.beRupiah(cartItem.quantity! *
                                                                            cartItem.price!),
                                                                    1,
                                                                    0);
                                                              }
                                                              printer
                                                                  .printNewLine();
                                                              printer.printCustom(
                                                                  "Total                  " +
                                                                      RupiahUtils.beRupiah(cartController
                                                                          .subtotal
                                                                          .toInt()),
                                                                  1,
                                                                  1);
                                                              printer
                                                                  .printNewLine();
                                                              printer.printCustom(
                                                                  "Bayar                  " +
                                                                      RupiahUtils.beRupiah(int.parse(ordersController
                                                                          .inputCashController
                                                                          .value
                                                                          .text)),
                                                                  1,
                                                                  1);
                                                              printer
                                                                  .printNewLine();
                                                              printer.printCustom(
                                                                  "Kembalian              " +
                                                                      // "1000",
                                                                      RupiahUtils.beRupiah(int.parse(ordersController.inputCashController.value.text) - cartController.subtotal.toInt()),
                                                                  1,
                                                                  1);
                                                              printer
                                                                  .printNewLine();
                                                              printer.printCustom(
                                                                  "Terima Kasih",
                                                                  1,
                                                                  1);
                                                              printer
                                                                  .printNewLine();
                                                              printer
                                                                  .printNewLine();
                                                              printer
                                                                  .printNewLine();
                                                            }
                                                          },
                                                          style:
                                                              const ButtonStyle(
                                                            foregroundColor:
                                                                MaterialStatePropertyAll(
                                                                    cYellowDark),
                                                            side:
                                                                MaterialStatePropertyAll(
                                                              BorderSide(
                                                                  color:
                                                                      cYellowDark),
                                                            ),
                                                          ),
                                                          child: Text("Cetak",
                                                              style: regular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      color:
                                                                          cYellowDark)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                          // SIZE
                                          //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                                          // ALIGN
                                          //0: LEFT, 1:CENTER, 2:RIFGT
                                          if ((await printer.isConnected)!) {
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Abramo Coffee", 2, 1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Jl. Pulasaren No. 102, Cirebon",
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Kasir : $userName", 1, 1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                DateFormat('HH:mm:ss').format(
                                                        DateTime.now()) +
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.now()),
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Pesanan", 1, 1);
                                            printer.printNewLine();
                                            for (var cartItem
                                                in cartController.cartItems) {
                                              printer.printCustom(
                                                  cartItem.name!, 1, 0);
                                              printer.printCustom(
                                                  "${cartItem.quantity!} x " +
                                                      RupiahUtils.beRupiah(
                                                          cartItem.price!) +
                                                      "         " +
                                                      RupiahUtils.beRupiah(
                                                          cartItem.quantity! *
                                                              cartItem.price!),
                                                  1,
                                                  0);
                                            }
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Total                  " +
                                                    RupiahUtils.beRupiah(
                                                        cartController.subtotal
                                                            .toInt()),
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Bayar                  " +
                                                    RupiahUtils.beRupiah(int
                                                        .parse(ordersController
                                                            .inputCashController
                                                            .value
                                                            .text)),
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Kembalian              " +
                                                    // "1000",
                                                    RupiahUtils.beRupiah(
                                                        int.parse(ordersController
                                                                .inputCashController
                                                                .value
                                                                .text) -
                                                            cartController
                                                                .subtotal
                                                                .toInt()),
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Terima Kasih", 1, 1);
                                            printer.printNewLine();
                                            printer.printNewLine();
                                            printer.printNewLine();
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
                      },
                      color: cYellowDark,
                      icon: const Icon(Icons.attach_money),
                    ),
                    const SizedBox(width: 10),
                    IconButtonComponent(
                      title: "QRIS",
                      onPressed: () {
                        Get.dialog(Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 250,
                            height: 450,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Pembayaran QRIS",
                                    style: bold.copyWith(
                                        fontSize: 20, color: cYellowDark)),
                                const SizedBox(height: 8),
                                Image.asset(
                                  "assets/images/qrcode.jpg",
                                  width: 300,
                                  height: 200,
                                ),
                                const SizedBox(height: 8),
                                Text("Total",
                                    textAlign: TextAlign.center,
                                    style: bold.copyWith(
                                        fontSize: 20, color: cYellowDark)),
                                const SizedBox(height: 5),
                                Text(
                                    RupiahUtils.beRupiah(
                                        cartController.subtotal.toInt()),
                                    textAlign: TextAlign.center,
                                    style: bold.copyWith(
                                        fontSize: 17, color: cYellowPrimary)),
                                const SizedBox(height: 10),
                                TextFieldOutlinedComponent(
                                    validator: "Nama konsumen harap diisi",
                                    hintText: "Nama Konsumen",
                                    textController: ordersController
                                        .customerNameController.value,
                                    keyboardType: TextInputType.text),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        Get.back();
                                        ordersController
                                            .customerNameController.value
                                            .clear();
                                      },
                                      style: const ButtonStyle(
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                cYellowDark),
                                        side: MaterialStatePropertyAll(
                                          BorderSide(color: cYellowDark),
                                        ),
                                      ),
                                      child: Text("Batal",
                                          style: regular.copyWith(
                                              fontSize: 15,
                                              color: cYellowDark)),
                                    ),
                                    const SizedBox(width: 10),
                                    OutlinedButton(
                                      style: const ButtonStyle(
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                cYellowDark),
                                        side: MaterialStatePropertyAll(
                                          BorderSide(color: cYellowDark),
                                        ),
                                      ),
                                      child: Text("Proses",
                                          style: regular.copyWith(
                                              fontSize: 15,
                                              color: cYellowDark)),
                                      onPressed: () async {
                                        cartController.cartItems.map((element) {
                                          var menuQty =
                                              _box.read("qtyMenu${element.id}");

                                          if (element.quantity! > menuQty) {
                                            Get.back();

                                            Get.snackbar("Kesalahan",
                                                "Tidak dapat memproses order, jumlah melebihi ketersediaan menu");
                                          }
                                        });

                                        if (cartController.cartItems.isEmpty) {
                                          Get.back();

                                          Get.snackbar("Kesalahan",
                                              "Tidak dapat memproses order, data keranjang tidak ada");
                                        }

                                        if (ordersController
                                            .customerNameController
                                            .value
                                            .text
                                            .isEmpty) {
                                          Get.back();

                                          Get.snackbar("Kesalahan",
                                              "Harap masukkan nama customer");
                                        }

                                        if (ordersController
                                            .customerNameController
                                            .value
                                            .text
                                            .isNotEmpty) {
                                          await ordersController.addOrders(
                                              ordersController
                                                  .customerNameController
                                                  .value
                                                  .text,
                                              userName,
                                              "QRIS",
                                              cartController.subtotal.toInt(),
                                              cartController.cartItems);

                                          Navigator.pop(context, true);

                                          Get.dialog(Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              width: 350,
                                              height: 450,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                        "Pembayaran Berhasil",
                                                        style: bold.copyWith(
                                                            fontSize: 20,
                                                            color:
                                                                cYellowDark)),
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Text("Metode Pembayaran",
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                  const SizedBox(height: 10),
                                                  Text("QRIS",
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color:
                                                              cYellowPrimary)),
                                                  const SizedBox(height: 15),
                                                  Text("Total Pembelian",
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                      RupiahUtils.beRupiah(
                                                          cartController
                                                              .subtotal
                                                              .toInt()),
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color:
                                                              cYellowPrimary)),
                                                  const SizedBox(height: 15),
                                                  Text("Nominal Bayar",
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                      RupiahUtils.beRupiah(
                                                          cartController
                                                              .subtotal
                                                              .toInt()),
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color:
                                                              cYellowPrimary)),
                                                  const SizedBox(height: 15),
                                                  Text("Kembalian",
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                      RupiahUtils.beRupiah(
                                                          cartController
                                                                  .subtotal
                                                                  .toInt() -
                                                              cartController
                                                                  .subtotal
                                                                  .toInt()),
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color:
                                                              cYellowPrimary)),
                                                  const SizedBox(height: 15),
                                                  Text("Waktu Pembayaran",
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                      DateFormat('HH:mm:ss')
                                                              .format(DateTime
                                                                  .now()) +
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(DateTime
                                                                  .now()),
                                                      style: bold.copyWith(
                                                          fontSize: 15,
                                                          color:
                                                              cYellowPrimary)),
                                                  const SizedBox(height: 25),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      OutlinedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, true);
                                                          cartController
                                                              .setSubtotalDefault();
                                                          cartController
                                                              .deleteAllData();
                                                          ordersController
                                                              .customerNameController
                                                              .value
                                                              .clear();
                                                          ordersController
                                                              .inputCashController
                                                              .value
                                                              .clear();
                                                          menusController
                                                              .getAllMenu();
                                                        },
                                                        style:
                                                            const ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStatePropertyAll(
                                                                  cYellowDark),
                                                          side:
                                                              MaterialStatePropertyAll(
                                                            BorderSide(
                                                                color:
                                                                    cYellowDark),
                                                          ),
                                                        ),
                                                        child: Text("Selesai",
                                                            style: regular.copyWith(
                                                                fontSize: 15,
                                                                color:
                                                                    cYellowDark)),
                                                      ),
                                                      OutlinedButton(
                                                        onPressed: () async {
                                                          // SIZE
                                                          //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                                                          // ALIGN
                                                          //0: LEFT, 1:CENTER, 2:RIFGT
                                                          if ((await printer
                                                              .isConnected)!) {
                                                            printer
                                                                .printNewLine();
                                                            printer.printCustom(
                                                                "Abramo Coffee",
                                                                2,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                            printer.printCustom(
                                                                "Jl. Pulasaren No. 102, Cirebon",
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                            printer.printCustom(
                                                                "Kasir : $userName",
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                            printer.printCustom(
                                                                DateFormat('HH:mm:ss').format(
                                                                        DateTime
                                                                            .now()) +
                                                                    DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(
                                                                            DateTime.now()),
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                            printer.printCustom(
                                                                "Pesanan",
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                            for (var cartItem
                                                                in cartController
                                                                    .cartItems) {
                                                              printer
                                                                  .printCustom(
                                                                      cartItem
                                                                          .name!,
                                                                      1,
                                                                      0);
                                                              printer.printCustom(
                                                                  "${cartItem.quantity!} x " +
                                                                      RupiahUtils.beRupiah(
                                                                          cartItem
                                                                              .price!) +
                                                                      "         " +
                                                                      RupiahUtils.beRupiah(cartItem
                                                                              .quantity! *
                                                                          cartItem
                                                                              .price!),
                                                                  1,
                                                                  0);
                                                            }
                                                            printer
                                                                .printNewLine();
                                                            printer.printCustom(
                                                                "Total                  " +
                                                                    RupiahUtils.beRupiah(cartController
                                                                        .subtotal
                                                                        .toInt()),
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                            printer.printCustom(
                                                                "Bayar                  " +
                                                                    RupiahUtils.beRupiah(cartController
                                                                        .subtotal
                                                                        .toInt()),
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                            printer.printCustom(
                                                                "Kembalian              " +
                                                                    // "1000",
                                                                    RupiahUtils.beRupiah(cartController
                                                                            .subtotal
                                                                            .toInt() -
                                                                        cartController
                                                                            .subtotal
                                                                            .toInt()),
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                            printer.printCustom(
                                                                "Terima Kasih",
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                            printer
                                                                .printNewLine();
                                                            printer
                                                                .printNewLine();
                                                          }
                                                        },
                                                        style:
                                                            const ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStatePropertyAll(
                                                                  cYellowDark),
                                                          side:
                                                              MaterialStatePropertyAll(
                                                            BorderSide(
                                                                color:
                                                                    cYellowDark),
                                                          ),
                                                        ),
                                                        child: Text("Cetak",
                                                            style: regular.copyWith(
                                                                fontSize: 15,
                                                                color:
                                                                    cYellowDark)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));

                                          // SIZE
                                          //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                                          // ALIGN
                                          //0: LEFT, 1:CENTER, 2:RIFGT
                                          if ((await printer.isConnected)!) {
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Abramo Coffee", 2, 1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Jl. Pulasaren No. 102, Cirebon",
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Kasir : $userName", 1, 1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                DateFormat('HH:mm:ss').format(
                                                        DateTime.now()) +
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.now()),
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Pesanan", 1, 1);
                                            printer.printNewLine();
                                            for (var cartItem
                                                in cartController.cartItems) {
                                              printer.printCustom(
                                                  cartItem.name!, 1, 0);
                                              printer.printCustom(
                                                  "${cartItem.quantity!} x " +
                                                      RupiahUtils.beRupiah(
                                                          cartItem.price!) +
                                                      "         " +
                                                      RupiahUtils.beRupiah(
                                                          cartItem.quantity! *
                                                              cartItem.price!),
                                                  1,
                                                  0);
                                            }
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Total                  " +
                                                    RupiahUtils.beRupiah(
                                                        cartController.subtotal
                                                            .toInt()),
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Bayar                  " +
                                                    RupiahUtils.beRupiah(
                                                        cartController.subtotal
                                                            .toInt()),
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Kembalian              " +
                                                    // "1000",
                                                    RupiahUtils.beRupiah(
                                                        cartController.subtotal
                                                                .toInt() -
                                                            cartController
                                                                .subtotal
                                                                .toInt()),
                                                1,
                                                1);
                                            printer.printNewLine();
                                            printer.printCustom(
                                                "Terima Kasih", 1, 1);
                                            printer.printNewLine();
                                            printer.printNewLine();
                                            printer.printNewLine();
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                      },
                      color: cYellowDark,
                      icon: const Icon(Icons.qr_code_scanner_outlined),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future loadImageInvoice() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocumentsDir.path}/image.png');
    if (file.existsSync()) {
      final bytes = await file.readAsBytes();

      setState(() {
        this.bytes = bytes;
      });
    }
  }

  Future saveImageInvoice(Uint8List bytes) async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocumentsDir.path}/image.png');
    file.writeAsBytes(bytes);

    log("PATH => ${appDocumentsDir.path}");
    log("File => $file");
  }

// void showDialog() {
//   Get.dialog(Dialog());
// }
}
