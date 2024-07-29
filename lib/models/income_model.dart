import 'package:json_annotation/json_annotation.dart';
part 'income_model.g.dart';

@JsonSerializable()
class IncomeModel {
  final String? status;
  final String? message;
  final String? data;

  const IncomeModel({
    this.status,
    this.message,
    this.data,
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeModelToJson(this);
}
