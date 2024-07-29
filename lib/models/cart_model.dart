import 'package:json_annotation/json_annotation.dart';
part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final int? id;
  final String? name;
  final int? price;
  final int? quantity;
  final String? image;
  final int? subTotalPerItem;

  const CartModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.image,
    this.subTotalPerItem,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['image'] = image;
    data['subTotalPerItem'] = subTotalPerItem;
    return data;
  }
}
