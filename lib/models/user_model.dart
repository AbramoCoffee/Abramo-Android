import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final String? name;
  final String? email;
  @JsonKey(name: "email_verified_at")
  final DateTime? emailVerifiedAt;
  @JsonKey(name: "two_factor_secret")
  final dynamic twoFactorSecret;
  @JsonKey(name: "two_factor_recovery_codes")
  final dynamic twoFactorRecoveryCodes;
  @JsonKey(name: "two_factor_confirmed_at")
  final dynamic twoFactorConfirmedAt;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  final String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
