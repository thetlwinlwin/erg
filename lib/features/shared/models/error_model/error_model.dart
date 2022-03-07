import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

abstract class BackendError<T> {
  final T detail;

  BackendError(this.detail);
}

@JsonSerializable(includeIfNull: false)
class CustomError extends BackendError<String> {
  CustomError(String detail) : super(detail);
  factory CustomError.fromJson(Map<String, dynamic> json) =>
      _$CustomErrorFromJson(json);
  Map<String, dynamic> toJson() => _$CustomErrorToJson(this);

  @override
  String toString() {
    return detail.toString();
  }
}

@JsonSerializable(includeIfNull: false)
class APIError extends BackendError<List<PydanticError>> {
  APIError(List<PydanticError> detail) : super(detail);
  factory APIError.fromJson(Map<String, dynamic> json) =>
      _$APIErrorFromJson(json);
  Map<String, dynamic> toJson() => _$APIErrorToJson(this);
  @override
  String toString() {
    return detail[0].msg.toString();
  }
}

@JsonSerializable(includeIfNull: false)
class PydanticError {
  final String? msg;
  PydanticError({
    this.msg,
  });
  factory PydanticError.fromJson(Map<String, dynamic> json) =>
      _$PydanticErrorFromJson(json);
  Map<String, dynamic> toJson() => _$PydanticErrorToJson(this);
}
