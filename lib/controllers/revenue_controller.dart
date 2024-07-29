import 'dart:developer';

import 'package:abramo_coffee/providers/revenue_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueController extends GetxController
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
  Rx<String> revenueToday = "".obs;
  Rx<String> revenueWeek = "".obs;
  Rx<String> revenueMonth = "".obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);
    getRevenueByTime("today");
    getRevenueByTime("this_week");
    getRevenueByTime("this_month");

    log("""
    ==== Init Controller====
    RevenueToday === $revenueToday
    RevenueWeek === $revenueWeek
    RevenueMonth === $revenueMonth
    === END =====
    """);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future getRevenueByTime(String time) async {
    try {
      isLoading.value = true;
      final revenue = await RevenueProvider.getRevenueByTime(time);

      if (time == "today") {
        revenueToday.value = revenue;
      }

      if (time == "this_week") {
        revenueWeek.value = revenue;
      }

      if (time == "this_month") {
        revenueMonth.value = revenue;
      }

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
