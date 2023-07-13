import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LanguageNotifier extends ChangeNotifier {
  String lang = 'en';
  String langKey = sharedLanguage;
  final Map<String, String> _supportedLanguages = const {
    "en": "English",
    "pl": "Polski",
  };

  MapEntry<String, String> _currentLanguage = const MapEntry(
    "en",
    "English",
  );

  MapEntry<String, String> get language => _currentLanguage;

  set currentLanguage(String code) {
    _currentLanguage = _supportedLanguages.entries
        .firstWhere((element) => element.key == code, orElse: () => language);
    notifyListeners();
  }

  String get currentLanguage {
    return _currentLanguage.key;
  }

  Map<String, String> get languages => _supportedLanguages;

  Future<bool> setLang(String val) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(langKey, val);
    return true;
  }

  Future<String> getLang() async {
    var prefs = await SharedPreferences.getInstance();
    lang = prefs.getString(langKey) ?? 'en';
    return lang;
  }
}
