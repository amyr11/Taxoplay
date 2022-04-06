import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper sp = SPHelper._();
  SharedPreferences? prefs;
  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setInt(String name, int value) async {
    await prefs!.setInt(name, value);
  }

  int? getInt(String key) {
    return prefs!.getInt(key) ?? 0;
  }

  Future<bool> empty(String key) async {
    return await prefs!.setInt(key, 0);
  }
}
