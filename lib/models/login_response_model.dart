import 'package:abramo_coffee/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponseModel {
  final String? status;
  final String? message;
  final String? token;
  final UserModel? user;

  const LoginResponseModel({
    this.status,
    this.message,
    this.token,
    this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
