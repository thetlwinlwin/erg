import 'package:shared_preferences/shared_preferences.dart';

abstract class Persistence {
  void setKey(String key, String value);
  String? getKey(String key);
  void removeKey(String key);
}

class LocalPersist implements Persistence {
  LocalPersist(this._sharedPrefs);
  final SharedPreferences _sharedPrefs;

  @override
  String? getKey(String key) => _sharedPrefs.getString(key);

  @override
  void setKey(String key, String value) async {
    _sharedPrefs.setString(key, value);
  }

  @override
  void removeKey(String key) => _sharedPrefs.remove(key);
}
