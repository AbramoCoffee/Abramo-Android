// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
      id: (json['id'] as num?)?.toInt(),
      invoice: json['invoice'] as String?,
      konsumen: json['konsumen'] as String?,
      cashier: json['cashier'] as String?,
      paymentMethod: json['payment_method'] as String?,
      totalPrice: (json['total_price'] as num?)?.toInt(),
      totalPaid: (json['total_paid'] as num?)?.toInt(),
      totalReturn: (json['total_return'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      dataItems: (json['data_items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice': instance.invoice,
      'konsumen': instance.konsumen,
      'cashier': instance.cashier,
      'payment_method': instance.paymentMethod,
      'total_price': instance.totalPrice,
      'total_paid': instance.totalPaid,
      'total_return': instance.totalReturn,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'data_items': instance.dataItems?.map((e) => e.toJson()).toList(),
    };
