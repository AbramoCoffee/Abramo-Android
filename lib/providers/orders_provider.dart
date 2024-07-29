import 'dart:convert';
import 'dart:developer';
import 'package:abramo_coffee/models/cart_model.dart';
import 'package:abramo_coffee/models/orders_model.dart';
import 'package:abramo_coffee/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import '../resources/constant.dart';
import '../resources/endpoint.dart';

class OrdersProvider {
  static Future<List<OrdersModel>> getAllOrders() async {
    String ordersUrl = "$baseUrl${Endpoint.api_orders}";

    final authData = await AuthProvider.getAuthData();

    List<OrdersModel> listOrdersModel = [];

    try {
      var response = await http.get(
        Uri.parse(ordersUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          OrdersModel ordersModel = OrdersModel.fromJson(data);
          listOrdersModel.add(ordersModel);
        }
      }

      log("List Orders Model => $listOrdersModel");

      return listOrdersModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<OrdersModel>> getAllOrdersByTime(String time) async {
    String ordersUrl = "$baseUrl${Endpoint.api_orders_time}$time";

    final authData = await AuthProvider.getAuthData();

    List<OrdersModel> listOrdersModel = [];

    try {
      var response = await http.get(
        Uri.parse(ordersUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          OrdersModel ordersModel = OrdersModel.fromJson(data);
          listOrdersModel.add(ordersModel);
        }
      }

      log("List Orders Model => $listOrdersModel");

      return listOrdersModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addOrders(String konsumen, String cashier,
      String paymentMethod, int totalPaid, List<CartModel> listCart) async {
    final Dio dio = Dio();

    String ordersUrl = baseUrl + Endpoint.api_orders;

    final authData = await AuthProvider.getAuthData();

    List<dynamic> listOrders = [];

    for (var cart in listCart) {
      listOrders.add({
        "menu_id": cart.id,
        "qty": cart.quantity,
      });
    }

    try {
      final data = {
        "konsumen": konsumen,
        "cashier": cashier,
        "payment_method": paymentMethod,
        "total_paid": totalPaid,
        "status": "proses",
        "ordered_items": listOrders
      };

      log("Data Order = $data");

      var response = await dio.post(
        ordersUrl,
        data: data,
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.token}',
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());
      } else {
        Get.snackbar("Gagal", response.data['message'].toString());
      }

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> editOrders(
      int id,
      String invoice,
      String konsumen,
      String cashier,
      String paymentMethod,
      int totalPrice,
      int totalPaid,
      int totalReturn,
      String status) async {
    final Dio dio = Dio();

    String ordersUrl = "$baseUrl${Endpoint.api_orders_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await dio.post(
        ordersUrl,
        data: FormData.fromMap(
          {
            'invoice': invoice,
            'konsumen': konsumen,
            'cashier': cashier,
            'payment_method': paymentMethod,
            'total_price': totalPrice,
            'total_paid': totalPaid,
            'total_return': totalReturn,
            'status': status,
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
}
