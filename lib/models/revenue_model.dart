import 'package:json_annotation/json_annotation.dart';
part 'revenue_model.g.dart';

@JsonSerializable()
class RevenueModel {
  final String? status;
  final String? message;
  final String? income;
  final String? outcome;
  final String? revenue;

  const RevenueModel({
    this.status,
    this.message,
    this.income,
    this.outcome,
    this.revenue,
  });

  factory RevenueModel.fromJson(Map<String, dynamic> json) =>
      _$RevenueModelFromJson(json);
  Map<String, dynamic> toJson() => _$RevenueModelToJson(this);
}
