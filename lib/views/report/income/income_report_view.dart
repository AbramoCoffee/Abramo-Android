import 'package:abramo_coffee/controllers/income_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/report/income/month_income_report_view.dart';
import 'package:abramo_coffee/views/report/income/today_income_report_view.dart';
import 'package:abramo_coffee/views/report/income/week_income_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeReportView extends StatelessWidget {
  const IncomeReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeController = Get.put(IncomeController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        foregroundColor: cWhite,
        title: Text(
          "Laporan Penjualan",
          style: bold.copyWith(fontSize: 25, color: cWhite),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: incomeController.tabController,
          tabs: incomeController.myTabs,
          labelColor: cWhite,
          indicatorColor: cWhite,
        ),
      ),
      body: TabBarView(
          controller: incomeController.tabController,
          children: const [
            TodayIncomeReportView(),
            WeekIncomeReportView(),
            MonthIncomeReportView(),
          ]),
    );
  }
}
