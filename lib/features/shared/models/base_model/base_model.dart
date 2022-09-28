import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable(includeIfNull: false)
class BaseDetailModel {
  @JsonKey(name: 'no_of_sheets')
  final int totalSheets;
  @JsonKey(name: 'length_per_sheet')
  final double lengthPerSheet;
  final double thickness;
  @JsonKey(name: 'total_length')
  final double totalLength;
  @JsonKey(name: 'pick_up_time')
  final DateTime pickupDate;
  @JsonKey(name: 'production_stage')
  String productionStage;
  String? notes;
  // totalLength = lengthPerSheet * totalSheets does not work and it did not send anything.
  BaseDetailModel({
    required this.totalSheets,
    required this.lengthPerSheet,
    required this.thickness,
    required this.pickupDate,
    required this.productionStage,
    this.notes,
  }) : totalLength = lengthPerSheet * totalSheets;
  factory BaseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BaseDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$BaseDetailModelToJson(this);
}
