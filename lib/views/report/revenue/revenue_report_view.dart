import 'package:abramo_coffee/controllers/revenue_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/report/revenue/month__revenue_report_view.dart';
import 'package:abramo_coffee/views/report/revenue/today__revenue_report_view.dart';
import 'package:abramo_coffee/views/report/revenue/week__revenue_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueReportView extends StatelessWidget {
  const RevenueReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final revenueController = Get.put(RevenueController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          "Laporan keuntungan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: revenueController.tabController,
          tabs: revenueController.myTabs,
          labelColor: cYellowDark,
          indicatorColor: cYellowDark,
        ),
      ),
      body: TabBarView(
          controller: revenueController.tabController,
          children: const [
            TodayRevenueReportView(),
            WeekRevenueReportView(),
            MonthRevenueReportView(),
          ]),
    );
  }
}
