// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenBearer _$AccessTokenBearerFromJson(Map<String, dynamic> json) =>
    AccessTokenBearer(
      accessTokenString: json['access_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
    );

Map<String, dynamic> _$AccessTokenBearerToJson(AccessTokenBearer instance) =>
    <String, dynamic>{
      'access_token': instance.accessTokenString,
      'token_type': instance.tokenType,
    };

ManagerBase _$ManagerBaseFromJson(Map<String, dynamic> json) => ManagerBase(
      name: json['name'] as String,
    );

Map<String, dynamic> _$ManagerBaseToJson(ManagerBase instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Manager _$ManagerFromJson(Map<String, dynamic> json) => Manager(
      name: json['name'] as String,
      password: json['password'] as String,
      type: json['type'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ManagerToJson(Manager instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'password': instance.password,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  return val;
}
