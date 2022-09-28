import 'dart:async';
import 'package:flutter/material.dart';
import '../repository/local_persistence.dart';

// class AppStateManager extends ChangeNotifier {
//   bool _initialized = false;

//   late Persistence _persistence;
//   late AccessTokenBearer _bearer;

//   String _user = '';
//   bool _loggedIn = false;

//   bool get isInitialized => _initialized;
//   bool get isLoggedIn => _loggedIn;

//   String get user => _user;
//   AccessTokenBearer get bearer => _bearer;

//   void initializeApp() async {
//     _persistence = await getSharedPref();

//     _readFromPersistence();
//     Timer(const Duration(milliseconds: 3000), () {
//       _initialized = true;
//       notifyListeners();
//     });
//   }

//   void _readFromPersistence() {
//     final String? getToken = _persistence.getKey(PrefKeys.accessTokenKey);
//     _user = _persistence.getKey(PrefKeys.usernameKey) ?? '';

//     if (getToken != null) {
//       _bearer = AccessTokenBearer(accessTokenString: getToken);
//       _loggedIn = true;
//     }
//   }

//   void login(
//       {required AccessTokenBearer tokenPayload, required String username}) {
//     _user = username;
//     _bearer = tokenPayload;
//     _persistence.setKey(
//         PrefKeys.accessTokenKey, tokenPayload.accessTokenString);
//     _persistence.setKey(PrefKeys.usernameKey, username);
//     _loggedIn = true;
//     notifyListeners();
//   }

//   void logout() {
//     _persistence.removeKey(PrefKeys.accessTokenKey);
//     _initialized = false;
//     _loggedIn = false;
//     notifyListeners();
//   }
// }

class AppStateManager extends ChangeNotifier {
  late final LocalPersist persist;
  AppStateManager({
    required this.persist,
  });
  bool _initialized = false;
  bool _loginState = false;
  bool _anyCustomer = false;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loginState;
  bool get anySavedCustomer => _anyCustomer;

  Future<void> onAppStart(
      {required bool isLoggedIn, required bool anyCustomer}) async {
    _loginState = isLoggedIn;
    _anyCustomer = anyCustomer;
    await Future.delayed(const Duration(milliseconds: 4000));
    _initialized = true;
    notifyListeners();
  }

  void login() {
    _loginState = true;
    notifyListeners();
  }

  void logout() {
    _initialized = false;
    _loginState = false;
    notifyListeners();
  }
}
