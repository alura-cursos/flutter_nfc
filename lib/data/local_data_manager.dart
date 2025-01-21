import 'package:flutter_banco_douro/helpers/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataManager {
  Future<void> saveTagId(String tagId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefsKeys.tagId, tagId);
  }

  Future<String?> readTagId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefsKeys.tagId);
  }

  Future<void> saveIsFirstTime(bool isFirstTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.isFirstTime, isFirstTime);
  }

  Future<bool> readIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefsKeys.isFirstTime) ?? true;
  }
}
