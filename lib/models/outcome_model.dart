import 'package:json_annotation/json_annotation.dart';
part 'outcome_model.g.dart';

@JsonSerializable()
class OutcomeModel {
  final String? status;
  final String? message;
  final String? data;

  const OutcomeModel({
    this.status,
    this.message,
    this.data,
  });

  factory OutcomeModel.fromJson(Map<String, dynamic> json) =>
      _$OutcomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$OutcomeModelToJson(this);
}
