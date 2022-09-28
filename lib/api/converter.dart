import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';

import '../features/shared/models/error_model/error_model.dart';

typedef CreateModelFromJson = dynamic Function(Map<String, dynamic> json);

class ModelConverter<Model> implements Converter {
  final CreateModelFromJson fromJson;
  final String? typeOfContent;
  ModelConverter({
    required this.fromJson,
    this.typeOfContent,
  });
  @override
  FutureOr<Request> convertRequest(Request request) async {
    if (request.url == '/refresh') {
      final req =
          applyHeader(request, contentTypeKey, jsonApiHeaders, override: false);
      return encodeJson(req);
    } else {
      final req =
          applyHeader(request, contentTypeKey, typeOfContent!, override: false);
      return encodeJson(req);
    }
  }

  Request encodeJson(Request request) {
    final contentType = request.headers[contentTypeKey];
    if (contentType != null) {
      if (contentType.contains(typeOfContent!) ||
          contentType.contains(jsonApiHeaders)) {
        return request.copyWith(body: json.encode(request.body));
      }
    }

    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final contentType = response.headers[contentTypeKey];
    var body = response.body;

    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    final mapData = _tryDecode(body);
    try {
      //TODO:this is how you do list of json into list of models.
      if (mapData.runtimeType == List) {
        Iterable l = mapData;
        final result = l.map((e) => fromJson(e) as Model).toList();
        return response.copyWith<BodyType>(body: result as BodyType);
      } else {
        final result = fromJson(mapData) as Model;
        return response.copyWith<BodyType>(body: result as BodyType);
      }
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(body: Exception(e) as BodyType);
    }
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
      Response response) async {
    return decodeJson(response);
  }
}

/// There are currently two types of error from my api.
///
/// That's why there is two try catch.
class ApiErrorConverter implements ErrorConverter {
  @override
  FutureOr<Response> convertError<BodyType, InnerType>(Response response) {
    return decodeJson(response);
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final supportedContentTypes = [jsonHeaders, jsonApiHeaders];

    final contentType = response.headers[contentTypeKey];
    var body = response.body;

    if (supportedContentTypes.contains(contentType)) {
      body = utf8.decode(response.bodyBytes);
    }

    body = _tryDecode(body);
    //TODO:this has to improve for further errors.
    try {
      body = APIError.fromJson(body);
    } catch (e) {
      chopperLogger.warning(e);
    }
    try {
      body = CustomError.fromJson(body);
    } catch (e) {
      chopperLogger.warning(e);
    }
    return response.copyWith<BodyType>(body: body);
  }
}

dynamic _tryDecode(dynamic responseBody) {
  try {
    return json.decode(responseBody);
  } catch (e) {
    chopperLogger.warning(e);
    return responseBody;
  }
}
