import 'package:shared_preferences/shared_preferences.dart';

abstract class Persistence {
  void setKey(String key, String value);
  String? getKey(String key);
  int? getIntKey(String key);
  void setIntKey(String key, int value);
  void removeKey(String key);
}

class SharedPreferencesPersistence implements Persistence {
  SharedPreferencesPersistence(this._sharedPrefs);
  final SharedPreferences _sharedPrefs;

  @override
  String? getKey(String key) => _sharedPrefs.getString(key);
  @override
  int? getIntKey(String key) => _sharedPrefs.getInt(key);

  @override
  void setKey(String key, String value) => _sharedPrefs.setString(key, value);

  @override
  void removeKey(String key) => _sharedPrefs.remove(key);

  @override
  void setIntKey(String key, int value) => _sharedPrefs.setInt(key, value);
}

Future<SharedPreferencesPersistence> getSharedPref() async {
  return SharedPreferencesPersistence(await SharedPreferences.getInstance());
}
