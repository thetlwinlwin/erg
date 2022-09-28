// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roof_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoofDataCreateModel _$RoofDataCreateModelFromJson(Map<String, dynamic> json) =>
    RoofDataCreateModel(
      customerId: json['customer_id'] as int,
      detail: RoofDetailModel.fromJson(
          json['roof_order_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoofDataCreateModelToJson(
        RoofDataCreateModel instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'roof_order_detail': instance.detail,
    };

RoofDetailModel _$RoofDetailModelFromJson(Map<String, dynamic> json) =>
    RoofDetailModel(
      color: json['color'] as String,
      manufacturer: json['manufacturer'] as String,
      totalSheets: json['no_of_sheets'] as int,
      lengthPerSheet: (json['length_per_sheet'] as num).toDouble(),
      thickness: (json['thickness'] as num).toDouble(),
      productionStage: json['production_stage'] as String,
      pickupDate: DateTime.parse(json['pick_up_time'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$RoofDetailModelToJson(RoofDetailModel instance) {
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
  val['color'] = instance.color;
  val['manufacturer'] = instance.manufacturer;
  return val;
}

RoofOrderFetchModel _$RoofOrderFetchModelFromJson(Map<String, dynamic> json) =>
    RoofOrderFetchModel(
      manager: ManagerBase.fromJson(json['manager'] as Map<String, dynamic>),
      customer: CustomerBase.fromJson(json['customer'] as Map<String, dynamic>),
      detail: RoofDetailModel.fromJson(
          json['roof_order_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoofOrderFetchModelToJson(
        RoofOrderFetchModel instance) =>
    <String, dynamic>{
      'manager': instance.manager,
      'customer': instance.customer,
      'roof_order_detail': instance.detail,
    };
