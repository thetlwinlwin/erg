import 'dart:async';
import 'package:erg/features/shared/models/auth/auth_model.dart';
import 'package:flutter/material.dart';
import '../repository/local_persistence.dart';

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;

  late Persistence _persistence;
  late AccessTokenBearer _bearer;

  String _user = '';
  bool _loggedIn = false;
  static const _accessTokenKey = 'access_token';
  static const _usernameKey = 'user';

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  String get user => _user;
  AccessTokenBearer get bearer => _bearer;

  void initializeApp() async {
    _persistence = await getSharedPref();
    _readFromPersistence();
    Timer(const Duration(milliseconds: 3000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void _readFromPersistence() {
    final String? getToken = _persistence.getKey(_accessTokenKey);
    final String? getUser = _persistence.getKey(_usernameKey);
    if (getUser != null) {
      _user = getUser;
    }
    if (getToken != null) {
      _bearer = AccessTokenBearer(accessTokenString: getToken);
      _loggedIn = true;
    }
  }

  void login(
      {required AccessTokenBearer tokenPayload, required String username}) {
    _user = username;
    _bearer = tokenPayload;
    _persistence.setKey(_accessTokenKey, tokenPayload.accessTokenString);
    _persistence.setKey(_usernameKey, username);
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _persistence.removeKey(_accessTokenKey);
    _initialized = false;
    _loggedIn = false;
    notifyListeners();
  }
}

final AppStateManager appStateManager = AppStateManager();
