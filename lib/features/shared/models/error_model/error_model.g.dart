// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomError _$CustomErrorFromJson(Map<String, dynamic> json) => CustomError(
      json['detail'] as String,
    );

Map<String, dynamic> _$CustomErrorToJson(CustomError instance) =>
    <String, dynamic>{
      'detail': instance.detail,
    };

APIError _$APIErrorFromJson(Map<String, dynamic> json) => APIError(
      (json['detail'] as List<dynamic>)
          .map((e) => PydanticError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$APIErrorToJson(APIError instance) => <String, dynamic>{
      'detail': instance.detail,
    };

PydanticError _$PydanticErrorFromJson(Map<String, dynamic> json) =>
    PydanticError(
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$PydanticErrorToJson(PydanticError instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('msg', instance.msg);
  return val;
}
