import 'package:abramo_coffee/models/category_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'menu_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MenuModel {
  final int? id;
  final String? code;
  @JsonKey(name: "category_id")
  final int? categoryId;
  final String? name;
  final String? description;
  final String? image;
  final int? price;
  final int? qty;
  final String? status;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  final CategoryModel? category;

  const MenuModel({
    this.id,
    this.code,
    this.categoryId,
    this.name,
    this.description,
    this.image,
    this.price,
    this.qty,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);
  Map<String, dynamic> toJson() => _$MenuModelToJson(this);
}
