import 'dart:convert';
import 'package:erg/features/shared/models/auth/auth_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_model.g.dart';

@JsonSerializable(includeIfNull: false)
class BaseDetailModel {
  final double length;
  final double thickness;
  @JsonKey(name: 'zinc_grade')
  final double grade;
  @JsonKey(name: 'pick_up_time')
  final DateTime pickupDate;
  @JsonKey(name: 'is_production_done')
  bool? isProductionDone;
  BaseDetailModel({
    required this.length,
    required this.thickness,
    required this.grade,
    required this.pickupDate,
    this.isProductionDone,
  });
  factory BaseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BaseDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$BaseDetailModelToJson(this);
}
