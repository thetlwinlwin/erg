// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDetailModel _$BaseDetailModelFromJson(Map<String, dynamic> json) =>
    BaseDetailModel(
      length: (json['length'] as num).toDouble(),
      thickness: (json['thickness'] as num).toDouble(),
      grade: (json['zinc_grade'] as num).toDouble(),
      pickupDate: DateTime.parse(json['pick_up_time'] as String),
      isProductionDone: json['is_production_done'] as bool?,
    );

Map<String, dynamic> _$BaseDetailModelToJson(BaseDetailModel instance) {
  final val = <String, dynamic>{
    'length': instance.length,
    'thickness': instance.thickness,
    'zinc_grade': instance.grade,
    'pick_up_time': instance.pickupDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('is_production_done', instance.isProductionDone);
  return val;
}
