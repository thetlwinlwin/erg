import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import '../features/shared/models/auth/auth_model.dart';
import '../managers/listener_manager.dart';
import 'auth/auth_api.dart';

class ErgAuth implements Authenticator {
  ListenerManager? manager;

  ErgAuth({
    this.manager,
  });

  @override
  FutureOr<Request?> authenticate(Request request, Response response,
      [Request? originalRequest]) async {
    if (response.statusCode == 401) {
      Map<String, dynamic> error = json.decode(utf8.decode(response.bodyBytes));
      if (error['detail'] == 'Could not validate credentials') {
        final Map<String, String> updatedHeaders =
            Map<String, String>.of(originalRequest!.headers);
        if (manager != null) {
          int callCount = 0;
          while (callCount < 4) {
            Response<AccessTokenBearer> newTokenObj =
                await ErgAuthService.create()
                    .refreshToken(refreshToken: manager!.getRefreshToken);
            if (newTokenObj.isSuccessful) {
              updatedHeaders.update(
                'Authorization',
                (String _) => newTokenObj.body.toString(),
                ifAbsent: () => newTokenObj.body.toString(),
              );
              manager?.revokeToken(bearer: newTokenObj.body!);
              callCount += 1;
              return originalRequest.copyWith(headers: updatedHeaders);
            }
          }
        }
      }
    }
    return null;
  }
}
