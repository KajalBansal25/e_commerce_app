import 'package:json_annotation/json_annotation.dart';

part 'user_verification_model.g.dart';

@JsonSerializable()
class UserVerificationModel {
  String? username;
  String? password;

  UserVerificationModel({this.username, this.password});

  factory UserVerificationModel.fromJson(Map<String, dynamic> json) => _$UserVerificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserVerificationModelToJson(this);
}
