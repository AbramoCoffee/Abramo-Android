import 'package:abramo_coffee/components/list_tile_component.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/report/income/income_report_view.dart';
import 'package:abramo_coffee/views/report/outcome/outcome_report_view.dart';
import 'package:abramo_coffee/views/report/revenue/revenue_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: cWhite,
          title: Text(
            "Laporan Penjualan",
            style: bold.copyWith(fontSize: 25, color: cYellowDark),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTileComponent(
                title: "Laporan Pendapatan",
                desc: "Manu untuk melihat laporan pendapatan",
                onTap: () {
                  Get.to(const IncomeReportView());
                },
              ),
              ListTileComponent(
                title: "Laporan Pengeluaran",
                desc: "Manu untuk melihat laporan pengeluaran",
                onTap: () {
                  Get.to(const OutcomeReportView());
                },
              ),
              ListTileComponent(
                title: "Laporan Keuntungan",
                desc: "Manu untuk melihat laporan keuntungan",
                onTap: () {
                  Get.to(const RevenueReportView());
                },
              ),
            ],
          ),
        ));
  }
}
