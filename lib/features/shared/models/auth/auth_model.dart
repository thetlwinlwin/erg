import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable(includeIfNull: false)
class AccessTokenBearer {
  @JsonKey(name: 'access_token')
  final String accessTokenString;
  @JsonKey(name: 'token_type')
  final String tokenType;
  AccessTokenBearer({
    required this.accessTokenString,
    this.tokenType = 'bearer',
  });

  factory AccessTokenBearer.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenBearerFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenBearerToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ManagerBase {
  final String name;

  ManagerBase({
    required this.name,
  });
  factory ManagerBase.fromJson(Map<String, dynamic> json) =>
      _$ManagerBaseFromJson(json);
  Map<String, dynamic> toJson() => _$ManagerBaseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Manager extends ManagerBase {
  final String password;
  final String? type;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Manager({
    required String name,
    required this.password,
    this.type,
    this.createdAt,
  }) : super(name: name);

  factory Manager.fromJson(Map<String, dynamic> json) =>
      _$ManagerFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ManagerToJson(this);
}
