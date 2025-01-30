// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      id: (json['id'] as num?)?.toInt(),
      orderId: (json['order_id'] as num?)?.toInt(),
      menuId: (json['menu_id'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      note: json['note'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      menu: json['menu'] == null
          ? null
          : MenuModel.fromJson(json['menu'] as Map<String, dynamic>),
      order: json['order'] == null
          ? null
          : OrdersModel.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'menu_id': instance.menuId,
      'qty': instance.qty,
      'price': instance.price,
      'note': instance.note,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'menu': instance.menu?.toJson(),
      'order': instance.order?.toJson(),
    };
