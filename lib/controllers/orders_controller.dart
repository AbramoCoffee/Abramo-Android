import 'dart:developer';
import 'dart:io';
import 'package:abramo_coffee/models/cart_model.dart';
import 'package:abramo_coffee/models/orders_model.dart';
import 'package:abramo_coffee/providers/orders_provider.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/services.dart';

import '../resources/color.dart';
import '../resources/font.dart';

class OrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: "Hari ini",
    ),
    const Tab(text: "Minggu ini"),
    const Tab(text: "Bulan ini"),
  ];

  RxBool isLoading = false.obs;
  Rx<TextEditingController> inputCashController = TextEditingController().obs;
  Rx<TextEditingController> customerNameController =
      TextEditingController().obs;

  RxList<OrdersModel> listOrdersModel = <OrdersModel>[].obs;
  RxList<OrdersModel> listOrdersModelToday = <OrdersModel>[].obs;
  RxList<OrdersModel> listOrdersModelWeek = <OrdersModel>[].obs;
  RxList<OrdersModel> listOrdersModelMonth = <OrdersModel>[].obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);
    getAllOrdersByTime("today");
    getAllOrdersByTime("today");
    getAllOrdersByTime("today");

    log("""
    ==== Init Controller====
    InvoiceModelToday === $listOrdersModelToday
    InvoiceModelWeek === $listOrdersModelWeek
    InvoiceModelMonth === $listOrdersModelMonth
    === END =====
    """);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future getAllOrders() async {
    try {
      isLoading.value = true;
      final invoices = await OrdersProvider.getAllOrders();
      listOrdersModel.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAllOrdersByTime(String time) async {
    try {
      isLoading.value = true;
      final listOrders = await OrdersProvider.getAllOrdersByTime(time);

      if (time == "today") {
        listOrdersModelToday.value = listOrders;
      }

      if (time == "this_week") {
        listOrdersModelWeek.value = listOrders;
      }

      if (time == "this_month") {
        listOrdersModelMonth.value = listOrders;
      }

      log("List Order Today => ${listOrdersModelToday}");
      log("List Order Week => $listOrdersModelWeek");
      log("List Order Month => $listOrdersModelMonth");

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addOrders(
      String konsumen,
      String cashier,
      String paymentMethod,
      int subTotal,
      int totalPrice,
      int totalPaid,
      int tax,
      List<CartModel> listCart) async {
    try {
      isLoading.value = true;

      var res = await OrdersProvider.addOrders(konsumen, cashier, paymentMethod,
          subTotal, totalPrice, totalPaid, tax, listCart);

      isLoading.value = false;
      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> editOrders(OrdersModel ordersModel) async {
    try {
      isLoading.value = true;
      var res = await OrdersProvider.editOrders(
          ordersModel.id!,
          ordersModel.invoice!,
          ordersModel.konsumen!,
          ordersModel.cashier!,
          ordersModel.paymentMethod!,
          ordersModel.totalPrice!,
          ordersModel.totalPaid!,
          ordersModel.totalReturn!,
          "selesai");
      isLoading.value = false;

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> generateAndSavePdf(String time, String incomeToday,
      String incomeWeek, String incomeMonth) async {
    final pdf = pw.Document();

    if (time == "today") {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Text("Laporan Penjualan",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Center(
                  child: pw.Table.fromTextArray(
                headers: ['No', 'Nomor Order', 'Jumlah'],
                data: List<List<String>>.generate(listOrdersModelToday.length,
                    (index) {
                  final ordersModel = listOrdersModelToday[index];
                  return [
                    (index + 1).toString(), // Column number (1-based index)
                    ordersModel.invoice!,
                    ordersModel.totalPrice.toString(),
                  ];
                }),
              )),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("Total Penjualan",
                      style: pw.TextStyle(
                          fontSize: 17, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(width: 20),
                  pw.Text(RupiahUtils.beRupiah(int.parse(incomeToday)),
                      style: pw.TextStyle(
                          fontSize: 17, fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ]);
          },
        ),
      );
    }

    if (time == "this_week") {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Text("Laporan Penjualan",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Center(
                  child: pw.Table.fromTextArray(
                headers: ['No', 'Nomor Order', 'Jumlah'],
                data: List<List<String>>.generate(listOrdersModelWeek.length,
                    (index) {
                  final ordersModel = listOrdersModelWeek[index];
                  return [
                    (index + 1).toString(), // Column number (1-based index)
                    ordersModel.invoice!,
                    ordersModel.totalPrice.toString(),
                  ];
                }),
              )),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("Total Penjualan",
                      style: pw.TextStyle(
                          fontSize: 17, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(width: 20),
                  pw.Text(RupiahUtils.beRupiah(int.parse(incomeWeek)),
                      style: pw.TextStyle(
                          fontSize: 17, fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ]);
          },
        ),
      );
    }

    if (time == "this_month") {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Text("Laporan Penjualan",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Center(
                  child: pw.Table.fromTextArray(
                headers: ['No', 'Nomor Order', 'Jumlah'],
                data: List<List<String>>.generate(listOrdersModelMonth.length,
                    (index) {
                  final ordersModel = listOrdersModelMonth[index];
                  return [
                    (index + 1).toString(), // Column number (1-based index)
                    ordersModel.invoice!,
                    ordersModel.totalPrice.toString(),
                  ];
                }),
              )),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("Total Penjualan",
                      style: pw.TextStyle(
                          fontSize: 17, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(width: 20),
                  pw.Text(RupiahUtils.beRupiah(int.parse(incomeMonth)),
                      style: pw.TextStyle(
                          fontSize: 17, fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ]);
          },
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  Future<void> openPdf(BuildContext context, String time, String incomeToday,
      String incomeWeek, String incomeMonth) async {
    try {
      final path =
          await generateAndSavePdf(time, incomeToday, incomeWeek, incomeMonth);
      await OpenFile.open(path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening PDF: $e')),
      );
    }
  }

  void exportPDF() async {
    // buat class pdf
    final pdf = pw.Document();

    // my font
    var dataFont = await rootBundle.load("assets/font/RoadRage-Regular.ttf");
    var myFont = pw.Font.ttf(dataFont);

    // my images
    var dataImage = await rootBundle.load("assets/images/logo.jpg");
    var myImage = dataImage.buffer.asUint8List();

    // buat pages
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.ClipRRect(
              horizontalRadius: 20,
              verticalRadius: 20,
              child: pw.Container(
                width: 350,
                height: 270,
                child: pw.Image(
                  pw.MemoryImage(myImage),
                  fit: pw.BoxFit.cover,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Container(
              color: PdfColors.red800,
              alignment: pw.Alignment.center,
              width: double.infinity,
              child: pw.Text(
                "MY PRODUCTS",
                style: pw.TextStyle(
                  fontSize: 50,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                  font: myFont,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Column(
              children: listOrdersModelToday
                  .map(
                    (e) => pw.Text(
                      "ada",
                      style: pw.TextStyle(
                        fontSize: 30,
                        font: myFont,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ];
        },
      ),
    ); // Page

    // simpan
    Uint8List bytes = await pdf.save();

    // buat file kosong di direktori
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mydocument.pdf');

    // timpa file kosong dengan file pdf
    await file.writeAsBytes(bytes);

    // open pdf
    await OpenFile.open(file.path);
  }
}
