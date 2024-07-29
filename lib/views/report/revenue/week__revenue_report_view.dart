import 'package:abramo_coffee/controllers/revenue_controller.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekRevenueReportView extends StatelessWidget {
  const WeekRevenueReportView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final revenueController = Get.put(RevenueController());
    revenueController.getRevenueByTime("this_week");

    return Scaffold(
      backgroundColor: cWhite,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Keuntungan Minggu Ini",
                  style: bold.copyWith(fontSize: 22, color: cYellowDark),
                ),
              ),
              const SizedBox(height: 15),
              Text("Total Keuntungan",
                  style: bold.copyWith(fontSize: 17, color: cYellowDark)),
              const SizedBox(height: 5),
              revenueController.revenueWeek.isNotEmpty
                  ? Text(
                      RupiahUtils.beRupiah(
                          int.parse(revenueController.revenueWeek.value)),
                      style: bold.copyWith(fontSize: 17, color: cYellowPrimary))
                  : Text(RupiahUtils.beRupiah(0),
                      style:
                          bold.copyWith(fontSize: 17, color: cYellowPrimary)),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
