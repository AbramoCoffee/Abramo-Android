import 'dart:convert';
import 'dart:developer';

import 'package:abramo_coffee/models/order_item_model.dart';
import 'package:abramo_coffee/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

import '../resources/constant.dart';
import '../resources/endpoint.dart';

class OrderItemProvider {
  static Future<OrderItemModel> getOrderItem(int id) async {
    String orderItemUrl = "$baseUrl${Endpoint.api_order_item_id}$id";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await http.get(
        Uri.parse(orderItemUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      log("Order Item Model => ${responseJson['data']}");

      return OrderItemModel.fromJson(responseJson['data']);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<OrderItemModel>> getAllOrderItem() async {
    String orderItemUrl = baseUrl + Endpoint.api_order_item;

    final authData = await AuthProvider.getAuthData();

    List<OrderItemModel> listOrderItemModel = [];

    try {
      var response = await http.get(
        Uri.parse(orderItemUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          OrderItemModel orderItemModel = OrderItemModel.fromJson(data);
          listOrderItemModel.add(orderItemModel);
        }
      }

      log("List Order Item Model => $listOrderItemModel");

      return listOrderItemModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<OrderItemModel>> getAllOrderItemByOrder(int id) async {
    String orderItemUrl = "$baseUrl${Endpoint.api_order_item_by_order_id}$id";

    final authData = await AuthProvider.getAuthData();

    List<OrderItemModel> listOrderItemModel = [];

    log("Url Order Item : $baseUrl${Endpoint.api_order_item_by_order_id}$id");

    try {
      var response = await http.get(
        Uri.parse(orderItemUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var data in responseJson["data"]) {
          OrderItemModel orderItemModel = OrderItemModel.fromJson(data);
          listOrderItemModel.add(orderItemModel);
        }
      }

      log("List Order Item Model => $listOrderItemModel");

      return listOrderItemModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
