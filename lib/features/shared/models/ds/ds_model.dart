// ignore_for_file: invalid_annotation_target
import 'package:erg/features/shared/models/auth/auth_model.dart';

import 'package:erg/features/shared/models/customers/customer_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base_model/base_model.dart';

part 'ds_model.g.dart';

@JsonSerializable(includeIfNull: false)
class DSDataCreateModel {
  @JsonKey(name: 'customer_id')
  final int customerId;
  final DSDetailModel detail;
  DSDataCreateModel({
    required this.customerId,
    required this.detail,
  });
  factory DSDataCreateModel.fromJson(Map<String, dynamic> json) =>
      _$DSDataCreateModelFromJson(json);
  Map<String, dynamic> toJson() => _$DSDataCreateModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DSDetailModel extends BaseDetailModel {
  @JsonKey(name: 'no_of_sheets')
  final int totalSheets;
  final double depth;

  DSDetailModel({
    required double length,
    required double thickness,
    required double grade,
    required DateTime pickupDate,
    required this.totalSheets,
    required this.depth,
  }) : super(
            length: length,
            thickness: thickness,
            grade: grade,
            pickupDate: pickupDate);
  factory DSDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DSDetailModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DSDetailModelToJson(this);
}

// for ds/orders/all
@JsonSerializable(includeIfNull: false)
class DSOrderFetchModel {
  final ManagerBase manager;
  final CustomerBase customer;
  @JsonKey(name: 'order_detail')
  final DSDetailModel detail;

  DSOrderFetchModel({
    required this.manager,
    required this.customer,
    required this.detail,
  });

  factory DSOrderFetchModel.fromJson(Map<String, dynamic> json) =>
      _$DSOrderFetchModelFromJson(json);
  Map<String, dynamic> toJson() => _$DSOrderFetchModelToJson(this);
}
