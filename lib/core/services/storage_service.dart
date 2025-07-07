import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  static Future<bool> setObject(String key, Map<String, dynamic> value) async {
    return await _prefs.setString(key, json.encode(value));
  }

  static Map<String, dynamic>? getObject(String key) {
    final String? data = _prefs.getString(key);
    if (data != null) {
      return json.decode(data) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
