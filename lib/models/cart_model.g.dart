// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      image: json['image'] as String?,
      subTotalPerItem: (json['subTotalPerItem'] as num?)?.toInt(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'image': instance.image,
      'subTotalPerItem': instance.subTotalPerItem,
      'note': instance.note,
    };
