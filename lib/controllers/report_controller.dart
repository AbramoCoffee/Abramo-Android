import 'dart:developer';

import 'package:abramo_coffee/models/report_model.dart';
import 'package:abramo_coffee/providers/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  Rx<bool> isLoading = false.obs;

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  Rx<ReportModel> reportModel = ReportModel().obs;
  RxList<ReportModel> listReportModel = <ReportModel>[].obs;
  RxList<ReportModel> listReportModelToday = <ReportModel>[].obs;
  RxList<ReportModel> listReportModelWeek = <ReportModel>[].obs;
  RxList<ReportModel> listReportModelMonth = <ReportModel>[].obs;

  @override
  void onInit() {
    getAllReportByTime("today");
    getAllReportByTime("this_week");
    getAllReportByTime("this_month");
    super.onInit();
  }

  populateFieldWhenEdit(ReportModel reportModel) {
    nameController.value.text = reportModel.name!;
    priceController.value.text = reportModel.price.toString();
    descriptionController.value.text = reportModel.description!;
  }

  void reset() {
    nameController.value.clear();
    descriptionController.value.clear();
  }

  Future getReport(int id) async {
    try {
      isLoading.value = true;
      final report = await ReportProvider.getReport(id);
      reportModel.value = report;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAllReport() async {
    try {
      isLoading.value = true;
      log("hehe");
      final listReport = await ReportProvider.getAllReport();
      listReportModel.value = listReport;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAllReportByTime(String time) async {
    try {
      isLoading.value = true;
      log("time : $time");
      final listReport = await ReportProvider.getAllReportByTime(time);

      if (time == "today") {
        listReportModelToday.value = listReport;
        log("==List REPORT tODAY== : $listReportModelToday");
      }

      if (time == "this_week") {
        listReportModelWeek.value = listReport;
        log("==List REPORT week== : $listReportModelWeek");
      }

      if (time == "this_month") {
        listReportModelMonth.value = listReport;
        log("==List REPORT MONTH== : $listReportModelMonth");
      }

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addReport() async {
    try {
      isLoading.value = true;

      var res = await ReportProvider.addReport(
          nameController.value.text,
          int.parse(priceController.value.text),
          descriptionController.value.text);

      isLoading.value = false;
      reset();
      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> editReport(ReportModel reportModel) async {
    try {
      isLoading.value = true;
      var res = await ReportProvider.editReport(
          reportModel.id!,
          nameController.value.text,
          int.parse(priceController.value.text),
          descriptionController.value.text);
      isLoading.value = false;

      reset();

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteReport(ReportModel reportModel) async {
    try {
      isLoading.value = true;
      var res = await ReportProvider.deleteReport(
        reportModel.id!,
      );
      isLoading.value = false;

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }
}
