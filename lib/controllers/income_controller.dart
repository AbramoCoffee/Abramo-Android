import 'dart:developer';

import 'package:abramo_coffee/providers/income_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeController extends GetxController
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
  Rx<String> incomeToday = "".obs;
  Rx<String> incomeWeek = "".obs;
  Rx<String> incomeMonth = "".obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);
    getIncomeByTime("today");
    getIncomeByTime("this_week");
    getIncomeByTime("this_month");

    log("""
    ==== Init Controller====
    IncomeToday === $incomeToday
    IncomeWeek === $incomeWeek
    IncomeMonth === $incomeMonth
    === END =====
    """);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future getIncomeByTime(String time) async {
    try {
      isLoading.value = true;
      final income = await IncomeProvider.getIncomeByTime(time);

      if (time == "today") {
        incomeToday.value = income;
      }

      if (time == "this_week") {
        incomeWeek.value = income;
      }

      if (time == "this_month") {
        incomeMonth.value = income;
      }

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
