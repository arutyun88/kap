import 'dart:convert';

extension LocaleExtension on Map {
  Map<String, Map<String, String>> get convertTo {
    Map<String, Map<String, String>> convertedMap = {};
    jsonDecode(jsonEncode(this)).forEach((key, value) {
      Map<String, String> subMap = {};
      value.forEach(
        (subKey, subValue) {
          if (subValue is String) subMap[subKey] = subValue;
        },
      );
      convertedMap[key] = subMap;
    });
    return convertedMap;
  }
}
