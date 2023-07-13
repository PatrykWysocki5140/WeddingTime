import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LocalPreferences {
  static const _keyLogged = sharedLogged;
  static const _keyDomain = sharedDomain;
  static const _keyUser = sharedUser;
  static const _keyPassword = sharedPassword;
  static const _keyToken = sharedToken;
  static const _keyfirstName = sharedFirstName;
  static const _keylastName = sharedLastName;

  static SharedPreferences? _prefs;
  static bool get logged => _prefs?.getBool(_keyLogged) ?? false;
  static set logged(bool value) => _prefs?.setBool(_keyLogged, value);

  static String get domain => _prefs?.getString(_keyDomain) ?? '';
  static set domain(String value) => _prefs?.setString(_keyDomain, value);

  static String get user => _prefs?.getString(_keyUser) ?? '';
  static set user(String value) => _prefs?.setString(_keyUser, value);

  static String get password => _prefs?.getString(_keyPassword) ?? '';
  static set password(String value) => _prefs?.setString(_keyPassword, value);

  static String get token => _prefs?.getString(_keyToken) ?? '';
  static set token(String value) => _prefs?.setString(_keyToken, value);

  static String get firstName => _prefs?.getString(_keyfirstName) ?? '';
  static set firstName(String value) => _prefs?.setString(_keyfirstName, value);

  static String get lastName => _prefs?.getString(_keylastName) ?? '';
  static set lastName(String value) => _prefs?.setString(_keylastName, value);

  LocalPreferences._();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> resetUser() async {
    _prefs?.remove(_keyLogged);
    _prefs?.remove(_keyDomain);
    _prefs?.remove(_keyUser);
    _prefs?.remove(_keyPassword);
    _prefs?.remove(_keyToken);
    _prefs?.remove(_keyfirstName);
    _prefs?.remove(_keylastName);
    //await _prefs?.clear();
  }

  static Future<void> resetAllData() async {
    await _prefs?.clear();
  }
}
