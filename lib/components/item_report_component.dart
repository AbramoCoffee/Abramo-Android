import 'package:abramo_coffee/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';

class ItemReportComponent extends StatelessWidget {
  const ItemReportComponent({Key? key, required this.reportModel, this.onTap})
      : super(key: key);

  final ReportModel reportModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 110,
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  reportModel.name!,
                  style: bold.copyWith(color: cYellowPrimary, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  RupiahUtils.beRupiah(reportModel.price!),
                  style: bold.copyWith(color: cYellowPrimary, fontSize: 15),
                ),
                const SizedBox(height: 5),
                Text(
                  reportModel.description!,
                  style: regular.copyWith(color: cYellowPrimary, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
