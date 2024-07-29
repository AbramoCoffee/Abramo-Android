import 'package:abramo_coffee/components/button_component.dart';
import 'package:abramo_coffee/components/text_field_outline_large_component.dart';
import 'package:abramo_coffee/components/text_field_outlined_component.dart';
import 'package:abramo_coffee/controllers/report_controller.dart';
import 'package:abramo_coffee/models/report_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOutcomeView extends StatelessWidget {
  final bool isEdit;
  final ReportModel? reportModel;

  const AddOutcomeView({
    super.key,
    this.isEdit = false,
    this.reportModel,
  });

  @override
  Widget build(BuildContext context) {
    final reportController = Get.put(ReportController());

    if (isEdit == false) {
      reportController.nameController.value.clear();
      reportController.priceController.value.clear();
      reportController.descriptionController.value.clear();
    }

    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          isEdit ? "Edit Pengeluaran" : "Tambah Pengeluaran",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Nama Pengeluaran",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Nama pengeluaran harap diisi",
                    hintText: "Nama Pengeluaran",
                    textController: reportController.nameController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                // DateTimeFieldComponent(
                //     controller: outcomeC.dateController.value,
                //     hintText: "Tanggal Pengeluaran",
                //     obsecureText: false),
                // const SizedBox(
                //   height: 20,
                // ),
                Text("Jumlah Pengeluaran",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    validator: "Jumlah pengeluaran harap diisi",
                    hintText: "Jumlah Pengeluaran",
                    textController: reportController.priceController.value,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                Text("Keterangan Pengeluaran",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedLargeComponent(
                    validator: "Keterangan harap diisi",
                    hintText: "Keterangan",
                    textController:
                        reportController.descriptionController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Center(
                  child: ButtonComponent(
                    "Kirim Berkas",
                    onPressed: () async {
                      var res = false;
                      if (!isEdit) {
                        res = await reportController.addReport();
                      } else {
                        res = await reportController.editReport(reportModel!);
                      }
                      Navigator.pop(context, res);
                    },
                    color: cYellowDark,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
