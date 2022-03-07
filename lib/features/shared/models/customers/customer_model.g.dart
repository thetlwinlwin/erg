// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBase _$CustomerBaseFromJson(Map<String, dynamic> json) => CustomerBase(
      name: json['name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$CustomerBaseToJson(CustomerBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
    };

CustomerCreate _$CustomerCreateFromJson(Map<String, dynamic> json) =>
    CustomerCreate(
      name: json['name'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$CustomerCreateToJson(CustomerCreate instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'phone': instance.phone,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address);
  val['gender'] = instance.gender;
  return val;
}

CustomerOut _$CustomerOutFromJson(Map<String, dynamic> json) => CustomerOut(
      name: json['name'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      address: json['address'] as String?,
      id: json['id'] as int,
    );

Map<String, dynamic> _$CustomerOutToJson(CustomerOut instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'phone': instance.phone,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address);
  val['gender'] = instance.gender;
  val['id'] = instance.id;
  return val;
}
