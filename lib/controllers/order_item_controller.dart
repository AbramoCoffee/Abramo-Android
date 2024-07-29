import 'dart:developer';

import 'package:abramo_coffee/models/order_item_model.dart';
import 'package:abramo_coffee/providers/order_item_provider.dart';
import 'package:get/get.dart';

class OrderItemController extends GetxController {
  Rx<bool> isLoading = false.obs;

  Rx<OrderItemModel> orderItemModel = OrderItemModel().obs;
  RxList<OrderItemModel> listOrderItemModel = <OrderItemModel>[].obs;

  Future getOrderItem(int id) async {
    try {
      isLoading.value = true;
      final orderItem = await OrderItemProvider.getOrderItem(id);
      orderItemModel.value = orderItem;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAllOrderItem() async {
    try {
      isLoading.value = true;
      log("hehe");
      final listorderItem = await OrderItemProvider.getAllOrderItem();
      listOrderItemModel.value = listorderItem;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAllOrderItemByOrder(int id) async {
    try {
      isLoading.value = true;
      log("ID ORDER = $id");
      final listorderItem = await OrderItemProvider.getAllOrderItemByOrder(id);
      listOrderItemModel.value = listorderItem;

      log("==list order item=== = ${listOrderItemModel.value}");

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
