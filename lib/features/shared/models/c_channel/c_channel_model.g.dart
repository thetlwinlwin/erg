// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CChannelCreateModel _$CChannelCreateModelFromJson(Map<String, dynamic> json) =>
    CChannelCreateModel(
      customerId: json['customer_id'] as int,
      detail: CChannelDetailModel.fromJson(
          json['cchannel_order_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CChannelCreateModelToJson(
        CChannelCreateModel instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'cchannel_order_detail': instance.detail,
    };

CChannelDetailModel _$CChannelDetailModelFromJson(Map<String, dynamic> json) =>
    CChannelDetailModel(
      channelHeight: (json['channel_height'] as num).toDouble(),
      channelWidth: (json['channel_width'] as num).toDouble(),
      grade: (json['zinc_grade'] as num).toDouble(),
      lengthPerSheet: (json['length_per_sheet'] as num).toDouble(),
      thickness: (json['thickness'] as num).toDouble(),
      pickupDate: DateTime.parse(json['pick_up_time'] as String),
      totalSheets: json['no_of_sheets'] as int,
      productionStage: json['production_stage'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CChannelDetailModelToJson(CChannelDetailModel instance) {
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
  val['channel_height'] = instance.channelHeight;
  val['channel_width'] = instance.channelWidth;
  val['zinc_grade'] = instance.grade;
  return val;
}

CChannelOrderFetchModel _$CChannelOrderFetchModelFromJson(
        Map<String, dynamic> json) =>
    CChannelOrderFetchModel(
      manager: ManagerBase.fromJson(
          json['cchannel_manager'] as Map<String, dynamic>),
      customer: CustomerCreate.fromJson(
          json['cchannel_customer'] as Map<String, dynamic>),
      detail: CChannelDetailModel.fromJson(
          json['cchannel_order_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CChannelOrderFetchModelToJson(
        CChannelOrderFetchModel instance) =>
    <String, dynamic>{
      'cchannel_manager': instance.manager,
      'cchannel_customer': instance.customer,
      'cchannel_order_detail': instance.detail,
    };
