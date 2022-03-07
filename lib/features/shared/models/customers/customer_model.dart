import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable(includeIfNull: false)
class CustomerBase {
  final String name;
  final String phone;

  CustomerBase({
    required this.name,
    required this.phone,
  });
  factory CustomerBase.fromJson(Map<String, dynamic> json) =>
      _$CustomerBaseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerBaseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CustomerCreate extends CustomerBase {
  final String? address;
  final String gender;

  CustomerCreate({
    required String name,
    required String phone,
    required this.gender,
    this.address,
  }) : super(name: name, phone: phone);

  factory CustomerCreate.fromJson(Map<String, dynamic> json) =>
      _$CustomerCreateFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CustomerCreateToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CustomerOut extends CustomerCreate {
  final int id;
  CustomerOut({
    required String name,
    required String phone,
    required String gender,
    String? address,
    required this.id,
  }) : super(name: name, phone: phone, gender: gender, address: address);

  factory CustomerOut.fromJson(Map<String, dynamic> json) =>
      _$CustomerOutFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CustomerOutToJson(this);
}

class CustomerDataPass {
  final String value;
  String? gender;
  CustomerDataPass({
    required this.value,
    this.gender,
  });
}
