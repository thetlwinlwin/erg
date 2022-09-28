import 'package:json_annotation/json_annotation.dart';

import 'package:erg/features/shared/models/auth/auth_model.dart';
import 'package:erg/features/shared/models/base_model/base_model.dart';
import 'package:erg/features/shared/models/customers/customer_model.dart';

part 'roof_model.g.dart';

@JsonSerializable(includeIfNull: false)
class RoofDataCreateModel {
  @JsonKey(name: 'customer_id')
  final int customerId;
  @JsonKey(name: 'roof_order_detail')
  final RoofDetailModel detail;
  RoofDataCreateModel({
    required this.customerId,
    required this.detail,
  });
  factory RoofDataCreateModel.fromJson(Map<String, dynamic> json) =>
      _$RoofDataCreateModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoofDataCreateModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RoofDetailModel extends BaseDetailModel {
  final String color;
  final String manufacturer;

  RoofDetailModel({
    required this.color,
    required this.manufacturer,
    required int totalSheets,
    required double lengthPerSheet,
    required double thickness,
    required String productionStage,
    required DateTime pickupDate,
    String? notes,
  }) : super(
          notes: notes,
          productionStage: productionStage,
          totalSheets: totalSheets,
          lengthPerSheet: lengthPerSheet,
          thickness: thickness,
          pickupDate: pickupDate,
        );

  factory RoofDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RoofDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoofDetailModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RoofOrderFetchModel {
  final ManagerBase manager;
  final CustomerBase customer;
  @JsonKey(name: 'roof_order_detail')
  final RoofDetailModel detail;
  RoofOrderFetchModel({
    required this.manager,
    required this.customer,
    required this.detail,
  });

  factory RoofOrderFetchModel.fromJson(Map<String, dynamic> json) =>
      _$RoofOrderFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoofOrderFetchModelToJson(this);
}
