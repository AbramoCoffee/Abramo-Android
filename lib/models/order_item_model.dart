import 'package:abramo_coffee/models/menu_model.dart';
import 'package:abramo_coffee/models/orders_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  final int? id;
  @JsonKey(name: "order_id")
  final int? orderId;
  @JsonKey(name: "menu_id")
  final int? menuId;
  final int? qty;
  final int? price;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  final MenuModel? menu;
  final OrdersModel? order;

  const OrderItemModel({
    this.id,
    this.orderId,
    this.menuId,
    this.qty,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.menu,
    this.order,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
