// ignore_for_file: invalid_annotation_target
import 'package:erg/features/shared/models/auth/auth_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base_model/base_model.dart';
import '../customers/customer_model.dart';

part 'c_channel_model.g.dart';

@JsonSerializable(includeIfNull: false)
class CChannelCreateModel {
  @JsonKey(name: 'customer_id')
  final int customerId;
  @JsonKey(name: 'cchannel_order_detail')
  final CChannelDetailModel detail;
  CChannelCreateModel({
    required this.customerId,
    required this.detail,
  });
  factory CChannelCreateModel.fromJson(Map<String, dynamic> json) =>
      _$CChannelCreateModelFromJson(json);
  Map<String, dynamic> toJson() => _$CChannelCreateModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CChannelDetailModel extends BaseDetailModel {
  @JsonKey(name: 'channel_height')
  final double channelHeight;
  @JsonKey(name: 'channel_width')
  final double channelWidth;
  @JsonKey(name: 'zinc_grade')
  final double grade;
  CChannelDetailModel({
    required this.channelHeight,
    required this.channelWidth,
    required this.grade,
    required double lengthPerSheet,
    required double thickness,
    required DateTime pickupDate,
    required int totalSheets,
    required String productionStage,
    String? notes,
  }) : super(
          productionStage: productionStage,
          notes: notes,
          lengthPerSheet: lengthPerSheet,
          totalSheets: totalSheets,
          pickupDate: pickupDate,
          thickness: thickness,
        );
  factory CChannelDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CChannelDetailModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CChannelDetailModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CChannelOrderFetchModel {
  @JsonKey(name: 'cchannel_manager')
  final ManagerBase manager;
  @JsonKey(name: 'cchannel_customer')
  final CustomerCreate customer;
  @JsonKey(name: 'cchannel_order_detail')
  final CChannelDetailModel detail;
  CChannelOrderFetchModel({
    required this.manager,
    required this.customer,
    required this.detail,
  });

  factory CChannelOrderFetchModel.fromJson(Map<String, dynamic> json) =>
      _$CChannelOrderFetchModelFromJson(json);
  Map<String, dynamic> toJson() => _$CChannelOrderFetchModelToJson(this);
}
