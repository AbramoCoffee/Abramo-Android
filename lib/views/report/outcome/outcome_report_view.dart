import 'package:abramo_coffee/controllers/outcome_controller.dart';
import 'package:abramo_coffee/controllers/report_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/report/outcome/month_outcome_report_view.dart';
import 'package:abramo_coffee/views/report/outcome/today_outcome_report_view.dart';
import 'package:abramo_coffee/views/report/outcome/week_outcome_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutcomeReportView extends StatelessWidget {
  const OutcomeReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final outcomeController = Get.put(OutcomeController());
    final reportController = Get.put(ReportController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          "Laporan Pegeluaran",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: outcomeController.tabController,
          tabs: outcomeController.myTabs,
          labelColor: cYellowDark,
          indicatorColor: cYellowDark,
        ),
      ),
      body: TabBarView(
          controller: outcomeController.tabController,
          children: const [
            TodayOutcomeReportView(),
            WeekOutcomeReportView(),
            MonthOutcomeReportView(),
          ]),
    );
  }
}
