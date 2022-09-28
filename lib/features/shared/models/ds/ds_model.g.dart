// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ds_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DSDataCreateModel _$DSDataCreateModelFromJson(Map<String, dynamic> json) =>
    DSDataCreateModel(
      customerId: json['customer_id'] as int,
      detail: DSDetailModel.fromJson(
          json['ds_order_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DSDataCreateModelToJson(DSDataCreateModel instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'ds_order_detail': instance.detail,
    };

DSDetailModel _$DSDetailModelFromJson(Map<String, dynamic> json) =>
    DSDetailModel(
      depth: (json['depth'] as num).toDouble(),
      grade: (json['zinc_grade'] as num).toDouble(),
      lengthPerSheet: (json['length_per_sheet'] as num).toDouble(),
      thickness: (json['thickness'] as num).toDouble(),
      pickupDate: DateTime.parse(json['pick_up_time'] as String),
      totalSheets: json['no_of_sheets'] as int,
      productionStage: json['production_stage'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$DSDetailModelToJson(DSDetailModel instance) {
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
  val['depth'] = instance.depth;
  val['zinc_grade'] = instance.grade;
  return val;
}

DSOrderFetchModel _$DSOrderFetchModelFromJson(Map<String, dynamic> json) =>
    DSOrderFetchModel(
      manager: ManagerBase.fromJson(json['ds_manager'] as Map<String, dynamic>),
      customer:
          CustomerCreate.fromJson(json['ds_customer'] as Map<String, dynamic>),
      detail: DSDetailModel.fromJson(
          json['ds_order_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DSOrderFetchModelToJson(DSOrderFetchModel instance) =>
    <String, dynamic>{
      'ds_manager': instance.manager,
      'ds_customer': instance.customer,
      'ds_order_detail': instance.detail,
    };
