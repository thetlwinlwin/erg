import 'package:shared_preferences/shared_preferences.dart';

abstract class DataContract<T> {
  Future<T?> getItem(String key);
  Future<void> setItem(Map<String, T> obj);
  Future<void> remove(String key);
}

class LocalPersist<T> extends DataContract<T> {
  final SharedPreferences pref;
  final List<String> keyList;

  final Map<String, dynamic> _items;
  LocalPersist({
    required this.pref,
    required this.keyList,
  }) : _items = {};

  @override
  Future<T?> getItem(String key) async => _items[key];

  void ready() {
    for (String e in keyList) {
      _items[e] = pref.getString(e);
    }
  }

  @override
  Future<void> remove(String key) async {
    _items[key];
    await pref.remove(key);
  }

  @override
  Future<void> setItem(Map<String, T> obj) async {
    obj.forEach((key, value) {
      _items[key] = value as dynamic;
      pref.setString(key, value as String);
    });
  }
}
