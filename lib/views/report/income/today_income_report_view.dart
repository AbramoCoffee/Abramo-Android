import 'dart:developer';

import 'package:abramo_coffee/controllers/income_controller.dart';
import 'package:abramo_coffee/controllers/orders_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayIncomeReportView extends StatelessWidget {
  const TodayIncomeReportView({
    super.key,
    // required this.income,
    // required this.listOrdersModelToday,
  });

  // final String income;
  // final List<OrdersModel> listOrdersModelToday;

  @override
  Widget build(BuildContext context) {
    final incomeController = Get.put(IncomeController());
    final ordersController = Get.put(OrdersController());

    incomeController.getIncomeByTime("today");
    ordersController.getAllOrdersByTime("today");
    // log("Income Today == $income");

    return Scaffold(
      backgroundColor: cWhite,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: ordersController.listOrdersModelToday.isNotEmpty
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
                      ordersController.listOrdersModelToday.length,
                      (index) {
                        final element =
                            ordersController.listOrdersModelToday[index];
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
        height: 140,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Penjualan",
                style: bold.copyWith(fontSize: 17, color: cYellowDark)),
            // const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: incomeController.incomeToday.isNotEmpty
                        ? Text(
                            RupiahUtils.beRupiah(
                                int.parse(incomeController.incomeToday.value)),
                            style: bold.copyWith(
                                fontSize: 19, color: cYellowPrimary))
                        : Text(RupiahUtils.beRupiah(0),
                            style: bold.copyWith(
                                fontSize: 19, color: cYellowPrimary))),
                ElevatedButton(
                  onPressed: () async {
                    incomeController.incomeToday.isNotEmpty
                        ? ordersController.openPdf(context, "today",
                            incomeController.incomeToday.value, "0", "0")
                        : ordersController.openPdf(
                            context, "today", "0", "0", "0");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: cWhite, foregroundColor: cYellowDark),
                  child: Text("Export",
                      style: bold.copyWith(color: cYellowDark, fontSize: 15)),
                ),
              ],
            ),
            // const SizedBox(height: 8),
            incomeController.incomeToday.isNotEmpty
                ? Text(
                    RupiahUtils.formatRupiahTerbilang(
                        int.parse(incomeController.incomeToday.value)),
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
