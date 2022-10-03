// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVerificationModel _$UserVerificationModelFromJson(
        Map<String, dynamic> json) =>
    UserVerificationModel(
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserVerificationModelToJson(
        UserVerificationModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
