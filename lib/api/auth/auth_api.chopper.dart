// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ErgAuthService extends ErgAuthService {
  _$ErgAuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ErgAuthService;

  @override
  Future<Response<AccessTokenBearer>> managerLoggingIn(
      String username, String password) {
    final $url = '/login';
    final $parts = <PartValue>[
      PartValue<String>('username', username),
      PartValue<String>('password', password)
    ];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<AccessTokenBearer, AccessTokenBearer>($request);
  }

  @override
  Future<Response<AccessTokenBearer>> refreshToken(
      {required RefreshToken refreshToken}) {
    final $url = '/refresh';
    final $body = refreshToken;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AccessTokenBearer, AccessTokenBearer>($request);
  }
}
