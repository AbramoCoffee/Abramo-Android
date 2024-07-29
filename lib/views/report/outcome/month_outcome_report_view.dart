import 'package:abramo_coffee/components/item_report_component.dart';
import 'package:abramo_coffee/controllers/outcome_controller.dart';
import 'package:abramo_coffee/controllers/report_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:abramo_coffee/views/report/outcome/add_outcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthOutcomeReportView extends StatelessWidget {
  const MonthOutcomeReportView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final outcomeController = Get.put(OutcomeController());
    final reportController = Get.put(ReportController());

    reportController.getAllReportByTime("this_month");
    outcomeController.getOutcomeByTime("this_month");

    return Scaffold(
      backgroundColor: cWhite,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await Get.to(const AddOutcomeView());

          if (res is bool) {
            if (res) {
              await reportController.getAllReportByTime("this_month");
              await outcomeController.getOutcomeByTime("this_month");
            }
          }
        },
        backgroundColor: cYellowDark,
        child: const Icon(Icons.add),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Pengeluaran Bulan Ini",
                      style: bold.copyWith(fontSize: 22, color: cYellowDark),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text("Total Pengeluaran",
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 5),
                  outcomeController.outcomeMonth.isNotEmpty
                      ? Text(
                          RupiahUtils.beRupiah(
                              int.parse(outcomeController.outcomeMonth.value)),
                          style: bold.copyWith(
                              fontSize: 17, color: cYellowPrimary))
                      : Text(RupiahUtils.beRupiah(0),
                          style: bold.copyWith(
                              fontSize: 17, color: cYellowPrimary)),
                  const SizedBox(height: 25),
                  const Divider(),
                  const Divider(),
                  Text("Daftar Pengeluaran",
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 5),
                  reportController.listReportModelMonth.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              'Tidak ada pengeluaran',
                              style: regular.copyWith(
                                  fontSize: 15, color: cYellowPrimary),
                            ),
                          ),
                        )
                      : Column(
                          children: reportController.listReportModelMonth
                              .map((element) =>
                                  ItemReportComponent(reportModel: element))
                              .toList()),
                ],
              ),
            ),
          )),
    );
  }
}
