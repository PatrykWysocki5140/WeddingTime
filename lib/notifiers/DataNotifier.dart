import 'dart:convert';

import 'package:flutter/foundation.dart';

class DataProvider with ChangeNotifier {
  final Map<int, bool> _iconsData = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false,
    10: false,
  };

  final Map<int, dynamic> _valueData = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false,
    10: false,
  };

  Map<int, bool> get iconsData => _iconsData;

  Map<int, dynamic> get valueData => _valueData;

  void resetData() {
    _iconsData.updateAll((key, value) => false);
    _valueData.updateAll((key, value) => null);
  }

  void updateIcon(int number, bool isSuccess) {
    _iconsData[number] = isSuccess;
    notifyListeners();
  }

/*
  void _updateMapValuesFromString(String input) {
    try {
      final decodedData = json.decode(input) as List<dynamic>;

      for (var segment in decodedData) {
        final segmentIndex = segment['segment'] as int;
        final angles = segment['angles'] as List<dynamic>;

        if (_valueData.containsKey(segmentIndex)) {
          _valueData[segmentIndex] = angles;
          if (angles.isNotEmpty) {
            _iconsData[segmentIndex] = true;
          }
        }
      }
    } on Exception catch (e) {
      dev.log(e.toString());
    }
  }
*/
  void _updateMapValuesFromString(String input) {
    try {
      final decodedData = json.decode(input) as Map<String, dynamic>;

      decodedData.forEach((key, value) {
        final segmentIndex = int.parse(key.split('_').last);
        final body = value.toString();

        if (_valueData.containsKey(segmentIndex)) {
          _valueData[segmentIndex] = body;
          if (body.isNotEmpty) {
            _iconsData[segmentIndex] = true;
          }
        }
      });
    } on Exception {}
  }

  void updateValues(String val) {
    _updateMapValuesFromString(val);
  }

  bool checkValues() {
    bool val;
    _isMapFullyFilled(_valueData) ? val = true : val = false;
    return val;
  }

  bool _isMapFullyFilled(Map<int, dynamic> map) {
    return map.values.every((value) => value != null);
  }
}
