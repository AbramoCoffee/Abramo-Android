import 'dart:convert';
import 'dart:developer';
import 'package:abramo_coffee/models/report_model.dart';
import 'package:abramo_coffee/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import '../resources/constant.dart';
import '../resources/endpoint.dart';

class ReportProvider {
  static Future<ReportModel> getReport(int id) async {
    String reportUrl = "$baseUrl${Endpoint.api_reports_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await http.get(
        Uri.parse(reportUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      log("Report Model => ${responseJson['data']}");

      return ReportModel.fromJson(responseJson['data']);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<ReportModel>> getAllReport() async {
    String reportUrl = baseUrl + Endpoint.api_reports;

    final authData = await AuthProvider.getAuthData();

    List<ReportModel> listReportModel = [];

    try {
      var response = await http.get(
        Uri.parse(reportUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          ReportModel reportModel = ReportModel.fromJson(data);
          listReportModel.add(reportModel);
        }
      }

      log("List Report Model => $listReportModel");

      return listReportModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<ReportModel>> getAllReportByTime(String time) async {
    String reportUrl = "$baseUrl${Endpoint.api_reports_time}$time";

    final authData = await AuthProvider.getAuthData();

    List<ReportModel> listReportModel = [];

    log("URL REPORT : $reportUrl");
    log("Token : ${authData.token}");

    try {
      var response = await http.get(
        Uri.parse(reportUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      log("Status code : ${response.statusCode}");
      log("Response Body : ${response.body}");

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          ReportModel reportModel = ReportModel.fromJson(data);
          listReportModel.add(reportModel);
        }
      }

      log("List Report Model => $listReportModel");

      return listReportModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addReport(
      String name, int price, String description) async {
    final Dio dio = Dio();

    String reportUrl = baseUrl + Endpoint.api_reports;

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await dio.post(
        reportUrl,
        data: FormData.fromMap(
          {
            'name': name,
            'price': price,
            'description': description,
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.token}',
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());

        return true;
      } else {
        Get.snackbar("Gagal", response.data['message'].toString());
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  static Future<bool> editReport(
      int id, String name, int price, String description) async {
    final Dio dio = Dio();

    String reportUrl = "$baseUrl${Endpoint.api_reports_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await dio.post(
        reportUrl,
        data: FormData.fromMap(
          {
            'name': name,
            'price': price,
            'description': description,
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.token}',
        }),
      );
      log("RESPONSE CODE == ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());

        return true;
      } else {
        Get.snackbar("Gagal", response.data['message'].toString());
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  static Future<bool> deleteReport(
    int id,
  ) async {
    String reportUrl = "$baseUrl${Endpoint.api_reports_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await http.delete(Uri.parse(reportUrl), headers: {
        'Authorization': 'Bearer ${authData.token}',
      });
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Report berhasil dihapus");
        Get.back();

        return true;
      } else {
        Get.snackbar("Gagal", "Report gagal dihapus");
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }
}
