import 'package:abramo_coffee/controllers/orders_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/views/history/month_history_view.dart';
import 'package:abramo_coffee/views/history/today_history_view.dart';
import 'package:abramo_coffee/views/history/week_history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersController = Get.put(OrdersController());
    ordersController.getAllOrdersByTime("today");
    ordersController.getAllOrdersByTime("this_week");
    ordersController.getAllOrdersByTime("this_month");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cYellowDark,
        title: Text(
          "Riwayat Order",
          style: bold.copyWith(fontSize: 25, color: cWhite),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: ordersController.tabController,
          tabs: ordersController.myTabs,
          labelColor: cWhite,
          indicatorColor: cWhite,
        ),
      ),
      body: TabBarView(controller: ordersController.tabController, children: [
        TodayHistoryView(
            listOrdersModelToday: ordersController.listOrdersModelToday),
        WeekHistoryView(
            listOrdersModelWeek: ordersController.listOrdersModelWeek),
        MonthHistoryView(
            listOrdersModelMonth: ordersController.listOrdersModelMonth),
      ]),
    );
  }
}
