import 'package:json_annotation/json_annotation.dart';
part 'report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportModel {
  final int? id;
  final String? name;
  final int? price;
  final String? description;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  const ReportModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
