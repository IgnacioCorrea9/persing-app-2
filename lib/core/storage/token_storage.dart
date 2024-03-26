import 'dart:async';

import 'package:persing/core/injection/global_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static TokenStorage get() {
    return getIt.get<TokenStorage>();
  }

  late SharedPreferences? _instance;
  static const _key = 'token';

  void setSharedPrefrence(SharedPreferences sharedPreferences) {
    _instance = sharedPreferences;
  }

  FutureOr<SharedPreferences?> _get() async {
    return _instance;
  }

  void clearPrefs() {
    _instance!.clear();
  }

  // SharedPreferences? _get() {
  //   return _instance;
  // }

  Future<bool> set(String token) async {
    return (await _get())!.setString(_key, token);
  }

  Future<String> gett() async {
    return (await _get())!.getString(_key) ?? "";
  }
}
