// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outcome_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutcomeModel _$OutcomeModelFromJson(Map<String, dynamic> json) => OutcomeModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$OutcomeModelToJson(OutcomeModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
