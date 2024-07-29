import 'dart:developer';

import 'package:abramo_coffee/providers/Outcome_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutcomeController extends GetxController
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
  Rx<String> outcomeToday = "".obs;
  Rx<String> outcomeWeek = "".obs;
  Rx<String> outcomeMonth = "".obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);
    getOutcomeByTime("today");
    getOutcomeByTime("this_week");
    getOutcomeByTime("this_month");

    log("""
    ==== Init Controller====
    OutcomeToday === $outcomeToday
    OutcomeWeek === $outcomeWeek
    OutcomeMonth === $outcomeMonth
    === END =====
    """);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future getOutcomeByTime(String time) async {
    try {
      isLoading.value = true;
      final outcome = await OutcomeProvider.getOutcomeByTime(time);

      if (time == "today") {
        outcomeToday.value = outcome;
      }

      if (time == "this_week") {
        outcomeWeek.value = outcome;
      }

      if (time == "this_month") {
        outcomeMonth.value = outcome;
      }

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
