import 'package:abramo_coffee/models/order_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'orders_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrdersModel {
  final int? id;
  final String? invoice;
  final String? konsumen;
  final String? cashier;
  @JsonKey(name: "payment_method")
  final String? paymentMethod;
  final int? subtotal;
  @JsonKey(name: "total_price")
  final int? totalPrice;
  @JsonKey(name: "total_paid")
  final int? totalPaid;
  @JsonKey(name: "total_return")
  final int? totalReturn;
  final int? tax;
  final String? status;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "data_items")
  final List<OrderItemModel>? dataItems;

  const OrdersModel(
      {this.id,
      this.invoice,
      this.konsumen,
      this.cashier,
      this.paymentMethod,
      this.subtotal,
      this.totalPrice,
      this.totalPaid,
      this.totalReturn,
      this.tax,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.dataItems});

  factory OrdersModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);
}
