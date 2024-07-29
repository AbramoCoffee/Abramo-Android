// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revenue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevenueModel _$RevenueModelFromJson(Map<String, dynamic> json) => RevenueModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      income: json['income'] as String?,
      outcome: json['outcome'] as String?,
      revenue: json['revenue'] as String?,
    );

Map<String, dynamic> _$RevenueModelToJson(RevenueModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'income': instance.income,
      'outcome': instance.outcome,
      'revenue': instance.revenue,
    };
