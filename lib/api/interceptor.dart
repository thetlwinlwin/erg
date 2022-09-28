import 'dart:async';

import 'package:chopper/chopper.dart';

import '../features/shared/models/auth/auth_model.dart';

class JWTAttachInterceptor implements RequestInterceptor {
  final AccessTokenBearer? tokenBearer;
  JWTAttachInterceptor({
    this.tokenBearer,
  });

  @override
  FutureOr<Request> onRequest(Request request) async {
    if (request.headers['Authorization'] == null && tokenBearer != null) {
      final Map<String, String> updatedHeaders =
          Map<String, String>.of(request.headers);
      updatedHeaders.update(
          'Authorization', (String _) => tokenBearer.toString(),
          ifAbsent: () => tokenBearer.toString());

      return request.copyWith(headers: updatedHeaders);
    } else {
      return request;
    }
  }
}
