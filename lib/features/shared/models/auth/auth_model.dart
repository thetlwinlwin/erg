import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable(includeIfNull: false)
class AccessTokenBearer {
  @JsonKey(name: 'access_token')
  final String accessTokenString;
  @JsonKey(name: 'refresh_token')
  final String refreshTokenString;
  @JsonKey(name: 'token_type')
  final String tokenType;
  AccessTokenBearer({
    required this.accessTokenString,
    required this.refreshTokenString,
    this.tokenType = 'Bearer',
  });

  factory AccessTokenBearer.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenBearerFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenBearerToJson(this);

  @override
  String toString() {
    return '$tokenType $accessTokenString';
  }
}

@JsonSerializable(includeIfNull: false)
class RefreshToken {
  @JsonKey(name: 'accepted_token')
  final String acceptedTokenString;
  RefreshToken({
    required this.acceptedTokenString,
  });
  factory RefreshToken.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenToJson(this);
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
