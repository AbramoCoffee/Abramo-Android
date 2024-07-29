import 'dart:developer';

import 'package:abramo_coffee/controllers/income_controller.dart';
import 'package:abramo_coffee/controllers/orders_controller.dart';
import 'package:abramo_coffee/models/orders_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthIncomeReportView extends StatelessWidget {
  const MonthIncomeReportView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final incomeController = Get.put(IncomeController());
    final ordersController = Get.put(OrdersController());

    var listName = [];

    incomeController.getIncomeByTime("this_month");
    ordersController.getAllOrdersByTime("this_month");

    return Scaffold(
      backgroundColor: cWhite,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: ordersController.listOrdersModelMonth.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Nomor Order')),
                      DataColumn(label: Text('Detail')),
                      DataColumn(label: Text('Jumlah')),
                    ],
                    rows: List<DataRow>.generate(
                      ordersController.listOrdersModelMonth.length,
                      (index) {
                        final element =
                            ordersController.listOrdersModelMonth[index];
                        return DataRow(cells: [
                          DataCell(Text("${index + 1}")),
                          DataCell(Text(element.invoice!)),
                          DataCell(SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: element.dataItems!.map((e) {
                                log("name menu ${index + 1} : ${e.menu!.name!}");
                                return Text(" - ${e.menu!.name!}");
                              }).toList(),
                            ),
                          )),
                          DataCell(Text(element.totalPrice.toString())),
                        ]);
                      },
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Tidak ada data',
                      style:
                          regular.copyWith(fontSize: 15, color: cYellowPrimary),
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.fromLTRB(25, 5, 15, 25),
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Penjualan",
                style: bold.copyWith(fontSize: 17, color: cYellowDark)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: incomeController.incomeMonth.isNotEmpty
                      ? Text(
                          RupiahUtils.beRupiah(
                              int.parse(incomeController.incomeMonth.value)),
                          style: bold.copyWith(
                              fontSize: 19, color: cYellowPrimary))
                      : Text(RupiahUtils.beRupiah(0),
                          style: bold.copyWith(
                              fontSize: 19, color: cYellowPrimary)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    incomeController.incomeMonth.isNotEmpty
                        ? ordersController.openPdf(context, "this_month", "0",
                            "0", incomeController.incomeMonth.value)
                        : ordersController.openPdf(
                            context, "this_month", "0", "0", "0");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: cWhite, foregroundColor: cYellowDark),
                  child: Text("Export",
                      style: bold.copyWith(color: cYellowDark, fontSize: 15)),
                ),
              ],
            ),
            incomeController.incomeMonth.isNotEmpty
                ? Text(
                    RupiahUtils.formatRupiahTerbilang(
                        int.parse(incomeController.incomeMonth.value)),
                    style:
                        regular.copyWith(fontSize: 12, color: cYellowPrimary))
                : Text(RupiahUtils.formatRupiahTerbilang(0),
                    style:
                        regular.copyWith(fontSize: 12, color: cYellowPrimary))
          ],
        ),
      ),
    );
  }
}
