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
  @JsonKey(name: 'ds_order_detail')
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
  final double depth;
  @JsonKey(name: 'zinc_grade')
  final double grade;

  DSDetailModel({
    required this.depth,
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
            totalSheets: totalSheets,
            lengthPerSheet: lengthPerSheet,
            thickness: thickness,
            pickupDate: pickupDate);

  factory DSDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DSDetailModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DSDetailModelToJson(this);
}

// for ds/orders/all
@JsonSerializable(includeIfNull: false)
class DSOrderFetchModel {
  @JsonKey(name: 'ds_manager')
  final ManagerBase manager;
  @JsonKey(name: 'ds_customer')
  final CustomerCreate customer;
  @JsonKey(name: 'ds_order_detail')
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
