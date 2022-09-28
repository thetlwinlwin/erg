import 'package:erg/repository/local_persistence.dart';

import '../features/shared/models/auth/auth_model.dart';
import 'persistencekeys.dart';

class ListenerManager {
  late final LocalPersist _persist;
  String? accessToken;
  String? listenerName;
  String? refreshToken;
  ListenerManager(this._persist) {
    fetchUserData();
  }

  bool get isManagerDataThere => accessToken != null;
  // bool get isThereRefreshToken => refreshToken != null ;
  RefreshToken get getRefreshToken =>
      RefreshToken(acceptedTokenString: refreshToken!);
  AccessTokenBearer get getAccessTokenBearer => AccessTokenBearer(
        accessTokenString: accessToken!,
        refreshTokenString: refreshToken!,
      );

  void fetchUserData() async {
    accessToken = _persist.getKey(PrefKeys.accessTokenKey);
    listenerName = _persist.getKey(PrefKeys.usernameKey);
    refreshToken = _persist.getKey(PrefKeys.refreshTokenKey);
  }

  // Need to return bool as we have to wait until we set the tokens.
  Future<bool> setUserData(
      {required AccessTokenBearer token, required String name}) async {
    accessToken = token.accessTokenString;
    refreshToken = token.refreshTokenString;
    listenerName = name;
    _persist.setKey(
      PrefKeys.usernameKey,
      name,
    );
    _persist.setKey(
      PrefKeys.accessTokenKey,
      token.accessTokenString,
    );
    _persist.setKey(
      PrefKeys.refreshTokenKey,
      token.refreshTokenString,
    );
    return true;
  }

  void revokeToken({required AccessTokenBearer bearer}) async {
    accessToken = bearer.accessTokenString;
    refreshToken = bearer.refreshTokenString;
    _persist.setKey(
      PrefKeys.accessTokenKey,
      bearer.accessTokenString,
    );
    _persist.setKey(
      PrefKeys.refreshTokenKey,
      bearer.refreshTokenString,
    );
  }

  void removeToken() {
    accessToken = null;
    refreshToken = null;
    _persist.removeKey(PrefKeys.accessTokenKey);
    _persist.removeKey(PrefKeys.refreshTokenKey);
  }
}
