// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ds_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DSDataCreateModel _$DSDataCreateModelFromJson(Map<String, dynamic> json) =>
    DSDataCreateModel(
      customerId: json['customer_id'] as int,
      detail: DSDetailModel.fromJson(json['detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DSDataCreateModelToJson(DSDataCreateModel instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'detail': instance.detail,
    };

DSDetailModel _$DSDetailModelFromJson(Map<String, dynamic> json) =>
    DSDetailModel(
      length: (json['length'] as num).toDouble(),
      thickness: (json['thickness'] as num).toDouble(),
      grade: (json['zinc_grade'] as num).toDouble(),
      pickupDate: DateTime.parse(json['pick_up_time'] as String),
      totalSheets: json['no_of_sheets'] as int,
      depth: (json['depth'] as num).toDouble(),
    )..isProductionDone = json['is_production_done'] as bool?;

Map<String, dynamic> _$DSDetailModelToJson(DSDetailModel instance) {
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
  val['no_of_sheets'] = instance.totalSheets;
  val['depth'] = instance.depth;
  return val;
}

DSOrderFetchModel _$DSOrderFetchModelFromJson(Map<String, dynamic> json) =>
    DSOrderFetchModel(
      manager: ManagerBase.fromJson(json['manager'] as Map<String, dynamic>),
      customer: CustomerBase.fromJson(json['customer'] as Map<String, dynamic>),
      detail:
          DSDetailModel.fromJson(json['order_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DSOrderFetchModelToJson(DSOrderFetchModel instance) =>
    <String, dynamic>{
      'manager': instance.manager,
      'customer': instance.customer,
      'order_detail': instance.detail,
    };
