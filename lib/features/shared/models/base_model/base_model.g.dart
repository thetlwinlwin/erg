// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDetailModel _$BaseDetailModelFromJson(Map<String, dynamic> json) =>
    BaseDetailModel(
      totalSheets: json['no_of_sheets'] as int,
      lengthPerSheet: (json['length_per_sheet'] as num).toDouble(),
      thickness: (json['thickness'] as num).toDouble(),
      pickupDate: DateTime.parse(json['pick_up_time'] as String),
      productionStage: json['production_stage'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$BaseDetailModelToJson(BaseDetailModel instance) {
  final val = <String, dynamic>{
    'no_of_sheets': instance.totalSheets,
    'length_per_sheet': instance.lengthPerSheet,
    'thickness': instance.thickness,
    'pick_up_time': instance.pickupDate.toIso8601String(),
    'production_stage': instance.productionStage,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notes', instance.notes);
  return val;
}
